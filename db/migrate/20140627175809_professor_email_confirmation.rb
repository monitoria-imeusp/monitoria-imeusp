class ProfessorEmailConfirmation < ActiveRecord::Migration
  def change
  	change_table :professors do |t|
  	  ## Confirmable
      t.string   :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string   :unconfirmed_email # Only if using reconfirmable
    end
  end
end
