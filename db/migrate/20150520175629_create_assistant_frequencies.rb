class CreateAssistantFrequencies < ActiveRecord::Migration
  def change
    create_table :assistant_frequencies do |t|
      t.integer :month
      t.boolean :presence
      t.integer :professor_id
      t.integer :role_id

      t.timestamps
    end
  end
end
