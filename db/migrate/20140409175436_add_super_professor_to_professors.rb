class AddSuperProfessorToProfessors < ActiveRecord::Migration
  def change
    add_column :professors, :super_professor, :boolean, default: false
  end
end
