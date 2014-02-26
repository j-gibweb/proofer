require 'spec_helper'

describe "recipient_lists/show" do
  before(:each) do
    @recipient_list = assign(:recipient_list, stub_model(RecipientList,
      :name => "Name",
      :list => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
  end
end
