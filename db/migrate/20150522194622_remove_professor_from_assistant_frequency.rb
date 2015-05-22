class RemoveProfessorFromAssistantFrequency < ActiveRecord::Migration
  def change
  	remove_column :assistant_frequencies, :professor_id
  end
end
