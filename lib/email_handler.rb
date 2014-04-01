module EmailHandler
	def send_email(options = {})
		options[:recipients].split(",").each do |recipient|
			AMAZON_SES.send_email(
				:to => "#{recipient}",
				:from => "\"#{options[:user].name}\" <j.gibweb@gmail.com>",
				:subject => "#{options[:subject]}",
				:html_body => "#{options[:html]}"
				)
		end
	end
end