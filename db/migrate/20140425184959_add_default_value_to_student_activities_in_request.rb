class AddDefaultValueToStudentActivitiesInRequest < ActiveRecord::Migration
  def up
    change_column_default :request_for_teaching_assistants,
      :student_assistance, false
    change_column_default :request_for_teaching_assistants,
      :work_correction, false
    change_column_default :request_for_teaching_assistants,
      :test_oversight, false
  end

  def down
    change_column_default :request_for_teaching_assistants,
      :student_assistance, nil
    change_column_default :request_for_teaching_assistants,
      :work_correction, nil
    change_column_default :request_for_teaching_assistants,
      :test_oversight, nil
  end
end
