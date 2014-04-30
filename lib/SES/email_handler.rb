module SES
  class EmailHandler
    def self.send_email(options = {})
      
      if options[:from_app]
        from_name = "Proofer-Mailer"
      else
        from_name = options[:user].name
      end
      
      options[:recipients].split(",").each do |recipient|
        AMAZON_SES.send_email(
          :to => "#{recipient}",
          :from => "\"#{from_name}\" <j.gibweb@gmail.com>",
          :subject => "#{options[:subject]}",
          :html_body => "#{options[:html]}"
          )
      end
    end
  end
end