require 'spec_helper'

describe "secretaries/index" do
  before(:each) do
    assign(:secretaries, [
      stub_model(Secretary,
        :nusp => "Nusp",
        :name => "Name",
        :email => "Email",
        :password => "Password"
      ),
      stub_model(Secretary,
        :nusp => "Nusp",
        :name => "Name",
        :email => "Email",
        :password => "Password"
      )
    ])
  end

  it "renders a list of secretaries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Nusp".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Password".to_s, :count => 2
  end
end
