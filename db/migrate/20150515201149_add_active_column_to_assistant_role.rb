class AddActiveColumnToAssistantRole < ActiveRecord::Migration
  def change
    add_column :assistant_roles, :active, :boolean
    change_column_default :assistant_roles, :active, true
  end
end
