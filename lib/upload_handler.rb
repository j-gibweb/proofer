module UploadHandler
	def unzip(zip, unzip_dir, remove_after = false)
		Zip::ZipFile.open(zip) do |zip_file|
			zip_file.each do |f|
				f_path=File.join(unzip_dir, f.name)
				FileUtils.mkdir_p(File.dirname(f_path))
				zip_file.extract(f, f_path) unless File.exist?(f_path)
			end
		end
		FileUtils.rm(zip) if remove_after
	end

	def push_assets_to_s3
		file_paths = Dir["#{path_to_project}/**/*"]
		directory = FOG_STORAGE.directories.get("proofer")
		threads = []
		file_paths.each do |f|
			next if f.include? "__MACOSX" or File.directory?(f)
			threads << Thread.new{
				f_path = f.sub(path_to_project, "")
				file = directory.files.create( :key => "#{self.campaign_name}#{f_path}", :body => File.open("#{f}"), :public => true )	
			}
		end
		threads.each(&:join)
	end
	
end