class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.integer :year
      t.integer :parity
      t.boolean :open

      t.timestamps
    end
    add_index :semesters, [:year, :parity], :unique => true
  end
end
