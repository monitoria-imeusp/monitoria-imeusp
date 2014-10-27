class AddSemesterToRequestForTeachingAssistant < ActiveRecord::Migration
  def up
    change_table :request_for_teaching_assistants do |t|
      t.belongs_to :semester
    end
    RequestForTeachingAssistant.all.each do |request|
      request.semester_id = Semester.first.id
      request.save
    end
  end
  def down
    change_table :request_for_teaching_assistants do |t|
      t.remove :semester_id
    end
  end
end
