require 'spec_helper'

describe "secretaries/show" do
  before(:each) do
    @secretary = assign(:secretary, stub_model(Secretary,
      :nusp => "Nusp",
      :name => "Name",
      :email => "Email",
      :password => "Password"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Nusp/)
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/Password/)
  end
end
