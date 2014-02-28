require 'spec_helper'

describe "promotionals/index" do
  before(:each) do
    assign(:promotionals, [
      stub_model(Promotional,
        :html => "MyText"
      ),
      stub_model(Promotional,
        :html => "MyText"
      )
    ])
  end

  it "renders a list of promotionals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
