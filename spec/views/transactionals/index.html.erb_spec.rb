require 'spec_helper'

describe "transactionals/index" do
  before(:each) do
    assign(:transactionals, [
      stub_model(Transactional,
        :xml => "MyText",
        :shell => "MyText"
      ),
      stub_model(Transactional,
        :xml => "MyText",
        :shell => "MyText"
      )
    ])
  end

  it "renders a list of transactionals" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
