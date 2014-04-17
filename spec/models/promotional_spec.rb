require 'spec_helper'
include S3
include Paperclip

describe Promotional do

  it "Creates Promotional type email object" do
  	expect(@promotional = Promotional.create(:html => "<body><p>test test</p></body>")).to be_instance_of(Promotional)
  end

  it "generates unique s3 bucket name from s3 helper class" do
  	expect(@helper = S3::Helper.new).to be_instance_of(Helper)
  	@promotional = Promotional.create(:html => "<body><p>test test</p></body>")
  	expect(S3::Helper.unique_file_name(@promotional)).to eq("#{@promotional.class}_#{@promotional.created_at}".gsub!(/:/,"").gsub!(/ /,"_").gsub!(/-/,"_").downcase)   
  end


  it "unzips an html email" do
  	@promotional = Promotional.create(:folder => "#{Rails.root}/test_upload_files/perfect_case.zip")

  	# puts @promotional.folder
  end


end
