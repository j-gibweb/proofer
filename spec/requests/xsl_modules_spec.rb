require 'spec_helper'

describe "XslModules" do
  describe "GET /xsl_modules" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get xsl_modules_path
      response.status.should be(200)
    end
  end
end
