class CreateAssistantRoles < ActiveRecord::Migration
  def change
    create_table :assistant_roles do |t|
      t.integer :student_id
      t.belongs_to :request

      t.timestamps
    end
  end
end
