class ListenerController < ApplicationController
	
	skip_before_filter :verify_authenticity_token 

	def receive_email
		@params = params
      @additional_recipients_only = false

		@email = Email.new(
			:subject => @params.to_s,
			:recipients => "shhtmltest@gmail.com",
			# :text => params["text"],
			:markup => params["html"],
			# :to => params["to"],
			# :from => params["from"],
			:subject => params["subject"]
			)
		if @email.markup.nil?
			@email.markup = "The body was empty for some reason"
		end
		scrubbed_html = @email.markup.match(/<!-- Beginning of XSLT Code -->(.*?)<!-- End of XSLT Code -->/m)
		@email.markup = scrubbed_html
		

		respond_to do |format|
		  if @email.save
		  	@email.send_emails_via_ses(User.last , @additional_recipients_only)
		    format.html { redirect_to @email, notice: "XSLT Email successfully created" }
		  else
		    format.html { render action: "new" }
		  end
		end
	end
end
