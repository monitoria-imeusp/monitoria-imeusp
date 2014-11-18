require 'spec_helper'

describe "advises/new" do
  before(:each) do
    assign(:advise, stub_model(Advise,
      :title => "MyString",
      :message => "MyString"
    ).as_new_record)
  end

  it "renders new advise form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", advises_path, "post" do
      assert_select "input#advise_title[name=?]", "advise[title]"
      assert_select "input#advise_message[name=?]", "advise[message]"
    end
  end
end
