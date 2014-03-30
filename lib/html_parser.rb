module HtmlParser
	def highlight_invalid_chars html
		@html = html
		@html.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '<span style="font-size:20px;color:#ca3536;"> INVALID CHARACTER </span>')
		@html = "HEY"
	end
end