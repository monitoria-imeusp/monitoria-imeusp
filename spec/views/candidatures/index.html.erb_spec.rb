require 'spec_helper'

describe "candidatures/index" do
  before(:each) do
    assign(:candidatures, [
      stub_model(Candidature,
        :avaliability_daytime => false,
        :avaliability_night_time => false,
        :time_period_preference => "Time Period Preference",
        :course1_id => 1,
        :course2_id => 2,
        :course3_id => 3
      ),
      stub_model(Candidature,
        :avaliability_daytime => false,
        :avaliability_night_time => false,
        :time_period_preference => "Time Period Preference",
        :course1_id => 1,
        :course2_id => 2,
        :course3_id => 3
      )
    ])
  end

  it "renders a list of candidatures" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "Time Period Preference".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
