require 'spec_helper'

describe "candidatures/show" do
  before(:each) do
    @candidature = assign(:candidature, stub_model(Candidature,
      :avaliability_daytime => false,
      :avaliability_night_time => false,
      :time_period_preference => "Time Period Preference",
      :course1_id => 1,
      :course2_id => 2,
      :course3_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/Time Period Preference/)
    rendered.should match(/1/)
    rendered.should match(/2/)
    rendered.should match(/3/)
  end
end
