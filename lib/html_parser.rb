module HtmlParser
	
	def highlight_invalid_chars html
		invalid_tag = '<span style="font-size:20px;color:#ca3536;"> INVALID CHARACTER </span>'
		html.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: invalid_tag )
	end

	def uploaded_images images_folder_name ,path 
		Dir["#{File.dirname(path)}/#{images_folder_name}/*"].map {|each| each.split("/").last}  
	end

	def go_nokogiri! object , html , path , bucket_name
		highlight_invalid_chars html
		page = Nokogiri::HTML(html) 
		tags = {'img' => 'src' , 'td' => 'background', 'table' => 'background'}
		images_folder_name = page.search('img').first.first[1].split("/").first if page

		# alter image paths with nokogiri 
		images_missing_from_folder = []
		page.search(tags.keys.join(",")).each do |node|
			url_param = tags[node.name]
			src = node[url_param]
			unless src == nil or src.include? "http" or src.length < 5 
				if uploaded_images(images_folder_name , path).include? src.split("/").last || ignore_images == true
					uri = URI.parse(src)
					image_path_name = "#{object.class}_#{object.id}".downcase
					node[url_param] = uri.path.sub(images_folder_name , "http://s3.amazonaws.com/#{bucket_name}/#{image_path_name}/#{images_folder_name}") 
				else 
					images_missing_from_folder << src.split("/").last.sub(self.images_folder_name+"\/","")
				end
			end
		end	
		return page		
	end

end