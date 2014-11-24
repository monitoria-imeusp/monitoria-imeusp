class CreateAdvises < ActiveRecord::Migration
  def change
    create_table :advises do |t|
      t.string :title
      t.string :message

      t.timestamps
    end
  end
end
