require 'spec_helper'

describe "transactionals/show" do
  before(:each) do
    @transactional = assign(:transactional, stub_model(Transactional,
      :xml => "MyText",
      :shell => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
  end
end
