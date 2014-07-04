class CreateDumps < ActiveRecord::Migration
  def change
    create_table :dumps do |t|

      t.timestamps
    end
  end
end
