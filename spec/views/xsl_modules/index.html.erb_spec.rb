require 'spec_helper'

describe "xsl_modules/index" do
  before(:each) do
    assign(:xsl_modules, [
      stub_model(XslModule,
        :xsl => "MyText",
        :order => 1,
        :transactional => ""
      ),
      stub_model(XslModule,
        :xsl => "MyText",
        :order => 1,
        :transactional => ""
      )
    ])
  end

  it "renders a list of xsl_modules" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
