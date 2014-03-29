require 'spec_helper'

describe "transactionals/new" do
  before(:each) do
    assign(:transactional, stub_model(Transactional,
      :xml => "MyText",
      :shell => "MyText"
    ).as_new_record)
  end

  it "renders new transactional form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", transactionals_path, "post" do
      assert_select "textarea#transactional_xml[name=?]", "transactional[xml]"
      assert_select "textarea#transactional_shell[name=?]", "transactional[shell]"
    end
  end
end
