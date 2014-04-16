require 'spec_helper'

describe "request_for_teaching_assistants/edit" do
  before(:each) do
    @request_for_teaching_assistant = assign(:request_for_teaching_assistant, stub_model(RequestForTeachingAssistant,
      :professor_id => 1,
      :subject => "MyString",
      :requestedNumber => 1,
      :priority => 1,
      :student_assistance => false,
      :work_correction => false,
      :test_oversight => false
    ))
  end

  it "renders the edit request_for_teaching_assistant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", request_for_teaching_assistant_path(@request_for_teaching_assistant), "post" do
      assert_select "input#request_for_teaching_assistant_professor_id[name=?]", "request_for_teaching_assistant[professor_id]"
      assert_select "input#request_for_teaching_assistant_subject[name=?]", "request_for_teaching_assistant[subject]"
      assert_select "input#request_for_teaching_assistant_requestedNumber[name=?]", "request_for_teaching_assistant[requestedNumber]"
      assert_select "input#request_for_teaching_assistant_priority[name=?]", "request_for_teaching_assistant[priority]"
      assert_select "input#request_for_teaching_assistant_student_assistance[name=?]", "request_for_teaching_assistant[student_assistance]"
      assert_select "input#request_for_teaching_assistant_work_correction[name=?]", "request_for_teaching_assistant[work_correction]"
      assert_select "input#request_for_teaching_assistant_test_oversight[name=?]", "request_for_teaching_assistant[test_oversight]"
    end
  end
end
