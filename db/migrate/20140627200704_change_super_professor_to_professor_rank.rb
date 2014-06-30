class ChangeSuperProfessorToProfessorRank < ActiveRecord::Migration
  def change
  	remove_column :professors, :super_professor
  	add_column :professors, :professor_rank, :bigint, default: 0
  end
end
