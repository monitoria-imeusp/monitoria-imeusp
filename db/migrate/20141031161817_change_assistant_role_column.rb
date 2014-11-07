class ChangeAssistantRoleColumn < ActiveRecord::Migration
  def change
    rename_column :assistant_roles, :request_id, :request_for_teaching_assistant_id
  end
end
