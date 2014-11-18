require 'spec_helper'

describe "advises/show" do
  before(:each) do
    @advise = assign(:advise, stub_model(Advise,
      :title => "Title",
      :message => "Message"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/Message/)
  end
end
