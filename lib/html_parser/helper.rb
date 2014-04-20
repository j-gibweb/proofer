module HtmlParser
  class Helper
    attr_accessor :object, :html, :path, :bucket_name, :mso_conditionals, :images_dir_name

    def initialize(options = {})
      self.object = options[:object]
      self.html = options[:html]
      self.path = options[:path]
      self.bucket_name = options[:bucket_name]
      self.images_dir_name = get_images_dir_name(Nokogiri::HTML(self.html))

      self.highlight_invalid_chars
      self.extract_commented_mso_conditionals
      @images_missing_from_html = self.change_html_image_paths_to_s3_bucket_paths
      @images_missing_from_css = self.change_css_image_paths_to_s3_bucket_path
      self.replace_commented_conditionals
    end

    def highlight_invalid_chars
      invalid_tag = '<span style="font-size:20px;color:#ca3536;"> INVALID CHARACTER </span>'
      self.html.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: invalid_tag )
    end

    def extract_commented_mso_conditionals
      mso_conditionals = []
      index = 0 
      while self.html.match(/<!--(.*?)-->/m).to_s != "" do 
        mso_conditionals[index] = self.html.match(/<!--(.*?)-->/m).to_s
        self.html.sub!( mso_conditionals[index], "_COMMENT_#{index.to_s}" ) 
        index += 1 
      end
      self.mso_conditionals = mso_conditionals
    end

    def change_html_image_paths_to_s3_bucket_paths
      page = Nokogiri::HTML(self.html)
      tags = {'img' => 'src' , 'td' => 'background', 'table' => 'background'}
      images_missing_from_html = []
      page.search(tags.keys.join(",")).each do |node|
        url_param = tags[node.name]
        src = node[url_param]
        unless self.invalid_html_element? src  
          if uploaded_image_names(self.images_dir_name, self.path).include? src.split("/").last #|| ignore_images == true
            uri = URI.parse(src)
            node[url_param] = uri.path.sub(self.images_dir_name, path_to_s3_bucket) 
          else 
            images_missing_from_html << src.split("/").last.sub(self.images_dir_name+"\/","")
          end
        end
      end 
      self.html = page.to_html
      return images_missing_from_html.uniq
    end

    def change_css_image_paths_to_s3_bucket_path
      css_string = self.html.match(/<style(.*?)<\/style>/m).to_s
      parser = CssParser::Parser.new
      parser.add_block!(css_string)
      images_missing_from_css = []
      parser.each_selector do |selector, declarations, specificity|
        if declarations.include? "background-image"
          unless self.invalid_html_element? declarations
            if uploaded_image_names(self.images_dir_name, self.path).any? {|img| declarations.include?(img)} #|| ignore_images == true
              change = declarations.sub!(self.images_dir_name, path_to_s3_bucket) 
              css_string.sub!(parser.find_by_selector(selector)[0],change) 
            else
              images_missing_from_css << declarations.match(/\((.*)\)/m).to_s
            end
          end
        end 
      end
      self.html.sub!(/<style(.*)<\/style>/m, css_string)
      return images_missing_from_css.uniq
    end

    def replace_commented_conditionals
      index = 0
      self.mso_conditionals.each do |condition|
        if condition.include? "src=\"#{self.images_dir_name}/"
          condition.sub!(self.images_dir_name, path_to_s3_bucket) 
        end
        self.html.sub!( "_COMMENT_#{index.to_s}", condition ) 
        index += 1
      end
    end   

    def invalid_html_element? element
      element == nil or element.include? "http" or element.length < 5 
    end

    def path_to_s3_bucket
      "http://s3.amazonaws.com/#{self.bucket_name}/#{S3::Helper.unique_file_name(self.object)}/#{self.images_dir_name}"
    end

    def uploaded_image_names images_dir_name, path 
      Dir["#{File.dirname(path)}/#{images_dir_name}/*"].map {|each| each.split("/").last}  
    end

    def get_images_dir_name html
      html.search('img').first.first[1].split("/").first if html
    end

    def self.html_file_path object
      Dir["#{File.dirname(object)}/**/*.htm*"][0]
    end

  end
end