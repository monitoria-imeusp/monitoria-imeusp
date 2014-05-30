require 'spec_helper'

describe "candidatures/new" do
  before(:each) do
    assign(:candidature, stub_model(Candidature,
      :avaliability_daytime => false,
      :avaliability_night_time => false,
      :time_period_preference => "MyString",
      :course1_id => 1,
      :course2_id => 1,
      :course3_id => 1
    ).as_new_record)
  end

  it "renders new candidature form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", candidatures_path, "post" do
      assert_select "input#candidature_avaliability_daytime[name=?]", "candidature[avaliability_daytime]"
      assert_select "input#candidature_avaliability_night_time[name=?]", "candidature[avaliability_night_time]"
      assert_select "input#candidature_time_period_preference[name=?]", "candidature[time_period_preference]"
      assert_select "input#candidature_course1_id[name=?]", "candidature[course1_id]"
      assert_select "input#candidature_course2_id[name=?]", "candidature[course2_id]"
      assert_select "input#candidature_course3_id[name=?]", "candidature[course3_id]"
    end
  end
end
