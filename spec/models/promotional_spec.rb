require 'spec_helper'

describe Promotional do

  describe "#update_markup!" do
    let(:html_helper) do
      double(:html_helper, :html => "<body>who cares</body>")
    end

    before do
      HtmlParser::Helper.stub(:new => html_helper)
    end

    it "should set the html" do
      # subject.update_markup!
      # expect(subject.html).to eq("<body>who cares</body>")
    end

    it "should save the record" do
      # subject.update_markup!
      # expect(subject).to be_persisted
    end
  end

end
