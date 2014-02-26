# require 'rspec_helpers'
require_relative '../spec_helper'

describe Email do 
	it "accepts an upload and does a bunch of stuff" do
		@email_w_zip = Email.create!(:subject=>"Testing", :recipients => "shhtmltest@gmail.com" , :folder => File.new(Rails.root + "test_upload_files/perfect_case.zip"))
		@email_w_html = Email.create!(:subject=>"Testing", :recipients => "shhtmltest@gmail.com" , :folder => File.new(Rails.root + "test_upload_files/no-images-folder-case.html"))

		@email_w_zip.upload_path.should be_an_instance_of(String)
		# @email_w_zip.set_campaign_name.should be_an_instance_of(String)
		# campaign_name = Dir["#{@email_w_zip.upload_path}/*.html"][0].split("/").last.split(".").first[0..20].gsub(/ /,"").gsub(/_/,"-").downcase+"-#{Time.now.to_i}"
		#campaign_name.should be_an_instance_of(String)
		# puts "\n\n"
		# puts @email_w_zip.upload_path
	end
end