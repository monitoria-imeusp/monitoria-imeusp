class StudentEmailConfirmation < ActiveRecord::Migration
  def change
  	change_table :students do |t|
  	  ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
  	end
  end
end
