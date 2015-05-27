class UpdateAssistantFrequencyColumnName < ActiveRecord::Migration
  def change
  	rename_column :assistant_frequencies, :role_id, :assistant_role_id
  end
end
