require 'spec_helper'

describe "advises/edit" do
  before(:each) do
    @advise = assign(:advise, stub_model(Advise,
      :title => "MyString",
      :message => "MyString"
    ))
  end

end
