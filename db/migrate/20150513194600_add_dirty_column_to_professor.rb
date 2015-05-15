class AddDirtyColumnToProfessor < ActiveRecord::Migration
  def change
    add_column :professors, :dirty, :boolean
    change_column_default :professors, :dirty, false
  end
end
