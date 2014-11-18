require 'spec_helper'

describe "advises/index" do
  before(:each) do
    assign(:advises, [
      stub_model(Advise,
        :title => "Title",
        :message => "Message"
      ),
      stub_model(Advise,
        :title => "Title",
        :message => "Message"
      )
    ])
  end

  it "renders a list of advises" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Message".to_s, :count => 2
  end
end
