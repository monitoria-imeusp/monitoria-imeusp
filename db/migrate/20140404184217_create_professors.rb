class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :name
      t.string :password
      t.string :nusp
      t.string :department
      t.string :email

      t.timestamps
    end
  end
end
