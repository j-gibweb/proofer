require 'spec_helper'
include S3

describe Promotional do

  it "Creates Promotional type email object" do
    expect(@promotional = Promotional.create(:html => "<body><p>test test</p></body>")).to be_instance_of(Promotional)
  end

  it "generates unique s3 bucket name from s3 helper class" do
    @promotional = Promotional.create(:html => "<body><p>test test</p></body>")
    expect(S3::Helper.unique_file_name(@promotional)).to eq("#{@promotional.class}_#{@promotional.created_at}".gsub!(/:/,"").gsub!(/ /,"_").gsub!(/-/,"_").downcase)   
  end

  it "unzips an html email .zip and uploads everything to s3" do
    @promotional = Promotional.create(:folder => File.new("#{Rails.root}/test_upload_files/perfect_case.zip"))
    S3::Helper.unzip(@promotional.folder.path , File.dirname(@promotional.folder.path) , true)
    S3::Helper.push_assets_to_s3(@promotional , "proofer-stage")
  end

  it "converts image file paths in HTML to the paths of the s3 bucket" do

  end 

end
