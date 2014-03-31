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
		# this can't be right
		system("rm -r #{path}") if path
	end

	def push_assets_to_s3 object , bucket
		threads = []
		inner_file_paths(object).each do |f|
			next if File.directory?(f)
			threads << Thread.new{
			puts "\n\n\nuploading an image\n\n\n"
				f_path = f.sub(File.dirname(f), "#{object.unique_s3_name}/#{images_dir_name(object)}".downcase )
				file = s3_directory(bucket).files.create( :key => "#{f_path}", :body => File.open(f), :public => true )	
			}
		end
		puts "joining the threads\n\n"
		threads.each(&:join)
	end

	def images_dir_name object
		File.basename(Dir["#{File.dirname(object.folder.path)}/*"].first)
	end

	def s3_directory bucket
		FOG_STORAGE.directories.get(bucket)
	end

	def inner_file_paths object
		Dir["#{File.dirname(object.folder.path)}/**/*"] 
	end

end