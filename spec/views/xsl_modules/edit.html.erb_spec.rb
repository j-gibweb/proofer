require 'spec_helper'

describe "xsl_modules/edit" do
  before(:each) do
    @xsl_module = assign(:xsl_module, stub_model(XslModule,
      :xsl => "MyText",
      :order => 1,
      :transactional => ""
    ))
  end

  it "renders the edit xsl_module form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", xsl_module_path(@xsl_module), "post" do
      assert_select "textarea#xsl_module_xsl[name=?]", "xsl_module[xsl]"
      assert_select "input#xsl_module_order[name=?]", "xsl_module[order]"
      assert_select "input#xsl_module_transactional[name=?]", "xsl_module[transactional]"
    end
  end
end
