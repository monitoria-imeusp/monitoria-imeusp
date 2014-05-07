class CreateRequestForTeachingAssistants < ActiveRecord::Migration
  def change
    create_table :request_for_teaching_assistants do |t|
      t.integer :professor_id
      t.string :subject
      t.integer :requestedNumber
      t.integer :priority
      t.boolean :student_assistance
      t.boolean :work_correction
      t.boolean :test_oversight

      t.timestamps
    end
  end
end
