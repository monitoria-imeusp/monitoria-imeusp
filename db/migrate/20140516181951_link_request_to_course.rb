class LinkRequestToCourse < ActiveRecord::Migration
  def change
      remove_column :request_for_teaching_assistants, :subject, :string
      change_table :request_for_teaching_assistants do | t |
          t.belongs_to :course
      end
      add_index :request_for_teaching_assistants, :course_id
  end
end
