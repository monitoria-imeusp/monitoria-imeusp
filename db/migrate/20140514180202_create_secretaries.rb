class CreateSecretaries < ActiveRecord::Migration
  def change
    create_table :secretaries do |t|
      t.string :nusp
      t.string :name
      t.string :email
      t.string :password

      t.timestamps
    end
  end
end
