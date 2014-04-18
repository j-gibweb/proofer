require 'spec_helper'
include S3
include HtmlParser
include SES

describe Promotional do

  it "Creates Promotional type email object" do
    expect(@promotional = Promotional.create(:html => "<body><p>test test</p></body>")).to be_instance_of(Promotional)
  end

  it "generates unique s3 bucket name from s3 helper class" do
    @promotional = Promotional.create(:html => "<body><p>test test</p></body>")
    expect(S3::Helper.unique_file_name(@promotional)).to eq("#{@promotional.class}_#{@promotional.created_at}".gsub!(/:/,"").gsub!(/ /,"_").gsub!(/-/,"_").downcase)   
  end

  it "unzips an html email .zip and uploads everything to s3 , then deletes the s3 bucket" do
    # @promotional = Promotional.create!(:folder => File.new("#{Rails.root}/test_upload_files/perfect_case.zip"))
    # S3::Helper.unzip(@promotional.folder.path , File.dirname(@promotional.folder.path) , true)
    # S3::Helper.push_assets_to_s3(@promotional , "proofer-stage")
    # S3::Helper.delete_bucket(@promotional , "proofer-stage")
  end

  it "converts image file paths in HTML to the paths of the s3 bucket" do
    @promotional = Promotional.create(:folder => File.new("#{Rails.root}/test_upload_files/perfect_case.zip"))
    S3::Helper.unzip(@promotional.folder.path , File.dirname(@promotional.folder.path) , true)
    html = File.read(HtmlParser::HtmlEmail.html_file_path(@promotional.folder.path))
    @promotional.html = HtmlParser::HtmlEmail.change_image_paths_to_s3_bucket(:object => @promotional , :html => html , :path => @promotional.folder.path , :bucket_name => "proofer-stage")
  end 

  it "send parsed html email via SES, to my email address!" do
    @user = User.create(:name => "James" , :email => "jweber@responsys.com")
    @promotional = Promotional.create(:folder => File.new("#{Rails.root}/test_upload_files/perfect_case.zip"))
    S3::Helper.unzip(@promotional.folder.path , File.dirname(@promotional.folder.path) , true)
    S3::Helper.push_assets_to_s3(@promotional , "proofer-stage")

    html_file = File.read(HtmlParser::HtmlEmail.html_file_path(@promotional.folder.path))
    @promotional.html = HtmlParser::HtmlEmail.change_image_paths_to_s3_bucket(:object => @promotional , :html => html_file , :path => @promotional.folder.path , :bucket_name => "proofer-stage")
    
    recipients = "jweber000@gmail.com , shhtmltest@gmail.com"    
    SES::EmailHandler.send_email(:recipients => recipients , :user => @user , :subject => "Hey it's a test" , :html => @promotional.html)
  end   


end
