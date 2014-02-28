require 'spec_helper'

describe "promotionals/show" do
  before(:each) do
    @promotional = assign(:promotional, stub_model(Promotional,
      :html => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
  end
end
