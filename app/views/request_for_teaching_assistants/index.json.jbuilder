json.array!(@request_for_teaching_assistants) do |request_for_teaching_assistant|
  json.extract! request_for_teaching_assistant, :id, :professor_id, :subject, :requestedNumber, :priority, :student_assistance, :work_correction, :test_oversight
  json.url request_for_teaching_assistant_url(request_for_teaching_assistant, format: :json)
end
