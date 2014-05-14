require 'spec_helper'

describe "secretaries/edit" do
  before(:each) do
    @secretary = assign(:secretary, stub_model(Secretary,
      :nusp => "MyString",
      :name => "MyString",
      :email => "MyString",
      :password => "MyString"
    ))
  end

  it "renders the edit secretary form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", secretary_path(@secretary), "post" do
      assert_select "input#secretary_nusp[name=?]", "secretary[nusp]"
      assert_select "input#secretary_name[name=?]", "secretary[name]"
      assert_select "input#secretary_email[name=?]", "secretary[email]"
      assert_select "input#secretary_password[name=?]", "secretary[password]"
    end
  end
end
