class AddFieldStudentIdToCandidatures < ActiveRecord::Migration
  def change
	  add_column :candidatures, :student_id, :integer
  end
end
