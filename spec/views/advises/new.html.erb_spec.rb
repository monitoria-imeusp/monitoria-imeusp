require 'spec_helper'

describe "advises/new" do
  before(:each) do
    assign(:advise, stub_model(Advise,
      :title => "MyString",
      :message => "MyString"
    ).as_new_record)
  end

end
