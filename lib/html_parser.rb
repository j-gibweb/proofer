module HtmlParser
	
	def highlight_invalid_chars html
		invalid_tag = '<span style="font-size:20px;color:#ca3536;"> INVALID CHARACTER </span>'
		html.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: invalid_tag )
	end

	def uploaded_images images_dir_name ,path 
		Dir["#{File.dirname(path)}/#{images_dir_name}/*"].map {|each| each.split("/").last}  
	end

	def go_nokogiri! object , html , path , bucket_name 
		highlight_invalid_chars html
		page = Nokogiri::HTML(html) 
		tags = {'img' => 'src' , 'td' => 'background', 'table' => 'background'}
		images_dir_name = page.search('img').first.first[1].split("/").first if page
		# alter image paths with nokogiri 
		images_missing_from_folder = []
		page.search(tags.keys.join(",")).each do |node|
			url_param = tags[node.name]
			src = node[url_param]
			unless src == nil or src.include? "http" or src.length < 5 
				if uploaded_images(images_dir_name , path).include? src.split("/").last || ignore_images == true
					uri = URI.parse(src)
					node[url_param] = uri.path.sub(images_dir_name , "http://s3.amazonaws.com/#{bucket_name}/#{unique_s3_name(object)}/#{images_dir_name}") 
				else 
					images_missing_from_folder << src.split("/").last.sub(images_dir_name+"\/","")
				end
			end
		end	
		check_for_missing_images images_missing_from_folder , page		
	end

	def check_for_missing_images images_missing_from_folder , page
		if !images_missing_from_folder.empty?
			return images_missing_from_folder
		else
			return page
		end
	end
	
end