require 'spec_helper'

describe Promotional do

  it "S3::Helper#unzip an html email zip and uploads everything with S3::Helper#push_assets_to_s3" do
    # expect(@promotional = Promotional.create!(:folder => File.new("#{Rails.root}/test_upload_files/perfect_case.zip"))).to be_instance_of(Promotional)
    # expect(S3::Helper.unzip(@promotional.folder.path, File.dirname(@promotional.folder.path), true)).to eq([Rails.root.to_s+"/public/assets/promotionals/#{@promotional.id}/perfect_case.zip"])
    # S3::Helper.push_assets_to_s3(@promotional, "proofer-stage")
    # S3::Helper.delete_bucket(@promotional, "proofer-stage")
  end

  # it "converts image file paths in HTML to the paths of the s3 bucket using HtmlParser::Helper inside the Promotional.update_markup! method" do
  #   @promotional = Promotional.create!(:folder => File.new("#{Rails.root}/test_upload_files/has_images/nested_example.zip"))
  #   S3::Helper.unzip(@promotional.folder.path, File.dirname(@promotional.folder.path), true)
  #   expect(@promotional.read_local_html).to eq(true)
  #   expect(@promotional.update_markup!).to eq(true)
  # end

  it "send parsed html email via SES::EmailHandler.send_email, to my email address!" do
    # skip
    # @user = User.create(:name => "James", :email => "jweber@responsys.com")
    # recipients = "jweber000@gmail.com"    
    # @promotional = Promotional.create(:folder => File.new("#{Rails.root}/test_upload_files/has_images/perfect_case.zip"))
    # S3::Helper.unzip(@promotional.folder.path, File.dirname(@promotional.folder.path), true)
    # S3::Helper.push_assets_to_s3(@promotional, "proofer-stage")
    # expect(@promotional.read_local_html).to eq(true)
    # expect(@promotional.update_markup!).to eq(true)
    # SES::EmailHandler.send_email(:recipients => recipients, :user => @user, :subject => "Hey it's a test", :html => @promotional.html)
  end
end
