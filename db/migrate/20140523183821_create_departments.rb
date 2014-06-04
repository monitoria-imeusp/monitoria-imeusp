class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :code 

      t.timestamps
    end
    add_index :departments, :code, :unique => true
  end
end
