require 'spec_helper'

describe "request_for_teaching_assistants/show" do
  before(:each) do
    @request_for_teaching_assistant = assign(:request_for_teaching_assistant, stub_model(RequestForTeachingAssistant,
      :professor_id => 1,
      :subject => "Subject",
      :requestedNumber => 2,
      :priority => 3,
      :student_assistance => false,
      :work_correction => false,
      :test_oversight => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Subject/)
    rendered.should match(/2/)
    rendered.should match(/3/)
    rendered.should match(/false/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
