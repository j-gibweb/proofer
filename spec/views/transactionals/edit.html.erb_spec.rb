require 'spec_helper'

describe "transactionals/edit" do
  before(:each) do
    @transactional = assign(:transactional, stub_model(Transactional,
      :xml => "MyText",
      :shell => "MyText"
    ))
  end

  it "renders the edit transactional form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transactional_path(@transactional), "post" do
      assert_select "textarea#transactional_xml[name=?]", "transactional[xml]"
      assert_select "textarea#transactional_shell[name=?]", "transactional[shell]"
    end
  end
end
