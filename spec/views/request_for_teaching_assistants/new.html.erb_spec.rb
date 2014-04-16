require 'spec_helper'

describe "request_for_teaching_assistants/new" do
  before(:each) do
    assign(:request_for_teaching_assistant, stub_model(RequestForTeachingAssistant,
      :professor_id => 1,
      :subject => "MyString",
      :requestedNumber => 1,
      :priority => 1,
      :student_assistance => false,
      :work_correction => false,
      :test_oversight => false
    ).as_new_record)
  end

  it "renders new request_for_teaching_assistant form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", request_for_teaching_assistants_path, "post" do
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
