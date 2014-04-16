require 'spec_helper'

describe "request_for_teaching_assistants/index" do
  before(:each) do
    assign(:request_for_teaching_assistants, [
      stub_model(RequestForTeachingAssistant,
        :professor_id => 1,
        :subject => "Subject",
        :requestedNumber => 2,
        :priority => 3,
        :student_assistance => false,
        :work_correction => false,
        :test_oversight => false
      ),
      stub_model(RequestForTeachingAssistant,
        :professor_id => 1,
        :subject => "Subject",
        :requestedNumber => 2,
        :priority => 3,
        :student_assistance => false,
        :work_correction => false,
        :test_oversight => false
      )
    ])
  end

  it "renders a list of request_for_teaching_assistants" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Subject".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
