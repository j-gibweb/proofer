# require 'spec_helper'
# require 'rspec_helpers'
require_relative '../spec_helper'

describe Email do 
	it "Accepts an unparsed html email, parses with nokogiri , uploads assets to S3, and sends via SES" do
		expect(@email_w_html = Email.create!(:subject=>"Testing", :recipients => "shhtmltest@gmail.com" , :folder => File.new(Rails.root + "test_upload_files/perfect_case.zip"))).to be_instance_of(Email)

		expect(@email_w_html.remove_zip).to eq(true)
	end
end