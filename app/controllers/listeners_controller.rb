class ListenersController < ApplicationController
	def receive_email
		@email = Email.new
		@params = params
		@inbound_email = InboundEmail.new(
			:text => params["text"],
			:html => params["html"],
			:to => params["to"],
			:from => params["from"],
			:subject => params["subject"]
			)

		respond_to do |format|
		  if @email.save
		    format.html { redirect_to @email, notice: "XSLT Email successfully created" }
		  else
		    format.html { render action: "new" }
		  end
		end
	end
end
