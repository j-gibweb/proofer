require 'spec_helper'

describe HtmlParser::Helper, :focus do 
  @promotional = Promotional.create!(:folder => File.new("#{Rails.root}/test_upload_files/has_images/nested_example.zip"))
  S3::Helper.unzip(@promotional.folder.path, File.dirname(@promotional.folder.path), true)
  S3::Helper.push_assets_to_s3(@promotional, "proofer-stage")
end