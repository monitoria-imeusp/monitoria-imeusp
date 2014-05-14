class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.string :password
      t.string :nusp
      t.integer :gender
      t.string :rg
      t.string :cpf
      t.string :adress
      t.string :complement
      t.string :district
      t.string :zipcode
      t.string :city
      t.string :state
      t.string :tel
      t.string :cel
      t.string :email
      t.boolean :has_bank_account

      t.timestamps
    end
  end
end
