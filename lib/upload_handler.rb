module UploadHandler
require 'zip/zip'

	def unzip(zip, unzip_dir, remove_after = false)
		Zip::ZipFile.open(zip) do |zip_file|
			zip_file.each do |f|
				f_path=File.join(unzip_dir, f.name)
				FileUtils.mkdir_p(File.dirname(f_path))
				zip_file.extract(f, f_path) unless File.exist?(f_path)
			end
		end
		FileUtils.rm(zip) if remove_after
		remove_macosx_unzip_dir zip
	end

	def remove_macosx_unzip_dir path_to_zip
		path = Dir["#{File.dirname(path_to_zip)}/__MACOSX/"].first
		recursive_remove_file path
	end

	def recursive_remove_file path
		system("rm -r #{path}") if path
	end

	def push_assets_to_s3 object , bucket
		file_paths = Dir["#{File.dirname(object.folder.path)}/**/*"]
		images_folder_name = File.basename(Dir["#{File.dirname(object.folder.path)}/*"].first)
		directory = FOG_STORAGE.directories.get(bucket)
		threads = []
		file_paths.each do |f|
			next if File.directory?(f)
			threads << Thread.new{
				f_path = f.sub(File.dirname(f), "#{object.class}_#{object.id}/#{images_folder_name}".downcase )
				file = directory.files.create( :key => "#{f_path}", :body => File.open(f), :public => true )	
			}
		end
		threads.each(&:join)
	end

end