require 'spec_helper'

describe "promotionals/edit" do
  before(:each) do
    @promotional = assign(:promotional, stub_model(Promotional,
      :html => "MyText"
    ))
  end

  it "renders the edit promotional form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", promotional_path(@promotional), "post" do
      assert_select "textarea#promotional_html[name=?]", "promotional[html]"
    end
  end
end
