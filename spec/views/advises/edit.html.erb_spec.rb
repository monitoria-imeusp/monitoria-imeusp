require 'spec_helper'

describe "advises/edit" do
  before(:each) do
    @advise = assign(:advise, stub_model(Advise,
      :title => "MyString",
      :message => "MyString"
    ))
  end

  it "renders the edit advise form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advise_path(@advise), "post" do
      assert_select "input#advise_title[name=?]", "advise[title]"
      assert_select "input#advise_message[name=?]", "advise[message]"
    end
  end
end
