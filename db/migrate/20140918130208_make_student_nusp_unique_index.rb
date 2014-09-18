class MakeStudentNuspUniqueIndex < ActiveRecord::Migration
  def change
    add_index :students, :nusp, :unique => true
  end
end
