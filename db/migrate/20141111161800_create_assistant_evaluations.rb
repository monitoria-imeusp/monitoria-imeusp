class CreateAssistantEvaluations < ActiveRecord::Migration
  def change
    create_table :assistant_evaluations do |t|
      t.belongs_to :assistant_role
      t.integer :ease_of_contact
      t.integer :efficiency
      t.integer :reliability
      t.integer :overall
      t.text :comment

      t.timestamps
    end
  end
end
