module S3
  class Helper
    
    def self.unique_file_name(object)
      "#{object.class}_#{object.created_at}".gsub!(/:/,"").gsub!(/ /,"_").gsub!(/-/,"_").downcase
    end
    
    def self.unzip(zip, unzip_dir, remove_after = false)
      Zip::ZipFile.open(zip) do |zip_file|
        zip_file.each do |f|
          f_path=File.join(unzip_dir, f.name)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exist?(f_path)
        end
      end
      FileUtils.rm(zip) if remove_after
      # puts Dir[File.dirname(zip)+"/**/*"]
    end

    def self.push_assets_to_s3 object , bucket 
      threads = []
      S3::Helper.inner_file_paths(object).each do |f|
        next if File.directory?(f) 
        threads << Thread.new{
          file_name = f.sub( File.dirname(f) , "" )
          if [".jpg" , ".gif" , ".png"].any? { |ext| file_name.include?(ext) } 
            key = "#{S3::Helper.unique_file_name(object)}/#{S3::Helper.images_dir_name(f)}#{file_name}"
          elsif file_name.include? ".htm" 
            key = "#{S3::Helper.unique_file_name(object)}#{file_name}"
          end
          file = FOG_STORAGE.directories.get(bucket).files.create( 
            :key => key , 
            :body => File.open(f), 
            :public => true 
            ) 
        }
      end
      threads.each(&:join)
    end

    def self.images_dir_name object
      "#{File.dirname(object).split("/").last}"
    end

    def self.inner_file_paths object
      Dir["#{File.dirname(object.folder.path)}/**/*"] 
    end

  end
end