class ListenerController < ApplicationController
	def receive_email
		
		@params = params
		@email = Email.new(
			# :text => params["text"],
			:markup => params["html"]
			# :to => params["to"],
			# :from => params["from"],
			# :subject => params["subject"]
			)
		@email.subject = @params.to_s

		respond_to do |format|
		  if @email.save
		    format.html { redirect_to @email, notice: "XSLT Email successfully created" }
		  else
		    format.html { render action: "new" }
		  end
		end
	end
end
