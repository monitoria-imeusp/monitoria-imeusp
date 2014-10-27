class AddInstituteTextToStudents < ActiveRecord::Migration
  def change
    add_column :students, :institute_text, :string
  end
end
