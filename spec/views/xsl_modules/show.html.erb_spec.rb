require 'spec_helper'

describe "xsl_modules/show" do
  before(:each) do
    @xsl_module = assign(:xsl_module, stub_model(XslModule,
      :xsl => "MyText",
      :order => 1,
      :transactional => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(//)
  end
end
