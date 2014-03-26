class ListenerController < ApplicationController
	def receive_email
		@params = params

		# if params[:additional_recipients_only]
      # @additional_recipients_only = true
    # else
      @additional_recipients_only = false
    # end

		@email = Email.new(
			:subject => @params.to_s,
			:recipients => "shhtmltest@gmail.com",
			# :text => params["text"],
			:markup => params["html"],
			# :to => params["to"],
			# :from => params["from"],
			# :subject => params["subject"]
			:subject => "test"
			)
		if @email.markup.nil?
			@email.markup = "The body was empty for some reason"
		end
		# @email.subject = @params.to_s
		# @email.recipients = "shhtmltest@gmail.com"
		respond_to do |format|
		  if @email.save
		  	@email.send_emails_via_ses(current_user , @additional_recipients_only)
		    format.html { redirect_to @email, notice: "XSLT Email successfully created" }
		  else
		    format.html { render action: "new" }
		  end
		end
	end
end
