require 'spec_helper'

describe "promotionals/new" do
  before(:each) do
    assign(:promotional, stub_model(Promotional,
      :html => "MyText"
    ).as_new_record)
  end

  it "renders new promotional form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", promotionals_path, "post" do
      assert_select "textarea#promotional_html[name=?]", "promotional[html]"
    end
  end
end
