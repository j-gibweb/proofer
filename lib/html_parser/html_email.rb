module HtmlParser
  class HtmlEmail

    def self.highlight_invalid_chars html
      invalid_tag = '<span style="font-size:20px;color:#ca3536;"> INVALID CHARACTER </span>'
      html.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: invalid_tag )
    end

    def self.uploaded_images images_dir_name ,path 
      Dir["#{File.dirname(path)}/#{images_dir_name}/*"].map {|each| each.split("/").last}  
    end

    def self.change_image_paths_to_s3_bucket options = {}
      HtmlParser::HtmlEmail.highlight_invalid_chars options[:html]
      page = Nokogiri::HTML(options[:html]) 
      tags = {'img' => 'src' , 'td' => 'background', 'table' => 'background'}
      images_dir_name = page.search('img').first.first[1].split("/").first if page
      images_missing_from_folder = []
      page.search(tags.keys.join(",")).each do |node|
        url_param = tags[node.name]
        src = node[url_param]
        unless src == nil or src.include? "http" or src.length < 5 
          if HtmlParser::HtmlEmail.uploaded_images(images_dir_name , options[:path]).include? src.split("/").last #|| ignore_images == true
            uri = URI.parse(src)
            node[url_param] = uri.path.sub(images_dir_name , "http://s3.amazonaws.com/#{options[:bucket_name]}/#{S3::Helper.unique_file_name(options[:object])}/#{images_dir_name}") 
          else 
            images_missing_from_folder << src.split("/").last.sub(images_dir_name+"\/","")
          end
        end
      end 
      HtmlParser::HtmlEmail.check_for_missing_images images_missing_from_folder , page
    end

    def self.check_for_missing_images images_missing_from_folder , page
      if !images_missing_from_folder.empty?
        images_missing_from_folder.unshift("Missing Images >> ")
        return images_missing_from_folder.to_s + page.to_html.to_s
      else
        return page.to_html
      end
    end

    def self.html_file_path object
      Dir["#{File.dirname(object)}/**/*.htm*"][0]
    end

  end
end