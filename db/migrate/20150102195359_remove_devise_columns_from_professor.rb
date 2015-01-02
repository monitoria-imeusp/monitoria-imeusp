class RemoveDeviseColumnsFromProfessor < ActiveRecord::Migration
  def up

    add_column :professors, :user_id, :integer

    Professor.all.each do |professor|
      user = User.new(email: professor.email, password: "placeholder phony fake", encrypted_password: professor.encrypted_password, remember_created_at: professor.remember_created_at, sign_in_count: professor.sign_in_count, current_sign_in_at: professor.current_sign_in_at, last_sign_in_at: professor.last_sign_in_at, current_sign_in_ip: professor.current_sign_in_ip, last_sign_in_ip: professor.last_sign_in_ip, confirmation_token: nil, confirmed_at: professor.confirmed_at, confirmation_sent_at: professor.confirmation_sent_at, unconfirmed_email: nil, nusp: professor.nusp, name: professor.name)
      unless user.valid?
        print user.errors.messages
        print user.nusp
        raise
      end
      user.save
      professor.user_id = user.id
      unless professor.valid?
        print professor.errors.messages
        print professor.nusp
        raise
      end
      professor.save
    end

    #### Devise columns
    ## Database authenticatable
    remove_column :professors, :encrypted_password, :string

    ## Recoverable
    remove_column :professors, :reset_password_token, :string
    remove_column :professors, :reset_password_sent_at, :datetime

    ## Rememberable
    remove_column :professors, :remember_created_at, :datetime

    ## Trackable
    remove_column :professors, :sign_in_count, :integer
    remove_column :professors, :current_sign_in_at, :datetime
    remove_column :professors, :last_sign_in_at, :datetime
    remove_column :professors, :current_sign_in_ip, :string
    remove_column :professors, :last_sign_in_ip, :string

    ## Confirmable
    remove_column :professors, :confirmation_token, :string
    remove_column :professors, :confirmed_at, :datetime
    remove_column :professors, :confirmation_sent_at, :datetime
    remove_column :professors, :unconfirmed_email, :string

    #### Common columns
    remove_column :professors, :name, :string
    remove_column :professors, :email, :string
    remove_column :professors, :nusp, :integer

  end

  def down

    #### Devise columns
    ## Database authenticatable
    add_column :professors, :encrypted_password, :string

    ## Recoverable
    add_column :professors, :reset_password_token, :string
    add_column :professors, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :professors, :remember_created_at, :datetime

    ## Trackable
    add_column :professors, :sign_in_count, :integer
    add_column :professors, :current_sign_in_at, :datetime
    add_column :professors, :last_sign_in_at, :datetime
    add_column :professors, :current_sign_in_ip, :string
    add_column :professors, :last_sign_in_ip, :string

    ## Confirmable
    add_column :professors, :confirmation_token, :string
    add_column :professors, :confirmed_at, :datetime
    add_column :professors, :confirmation_sent_at, :datetime
    add_column :professors, :unconfirmed_email, :string

    #### Common columns
    add_column :professors, :name, :string
    add_column :professors, :email, :string
    add_column :professors, :nusp, :integer


    Professor.all.each do |professor|
      user = User.find(professor.user_id)
      professor.email = user.email
      professor.encrypted_password = user.encrypted_password
      professor.remember_created_at = user.remember_created_at
      professor.sign_in_count = user.sign_in_count
      professor.current_sign_in_at = user.current_sign_in_at
      professor.last_sign_in_at = user.last_sign_in_at
      professor.current_sign_in_ip = user.current_sign_in_ip
      professor.last_sign_in_ip = user.last_sign_in_ip
      professor.confirmation_token = user.confirmation_token
      professor.confirmed_at = user.confirmed_at
      professor.confirmation_sent_at = user.confirmation_sent_at
      professor.unconfirmed_email = user.unconfirmed_email
      professor.nusp = "#{user.nusp}"
      professor.name = user.name
      user.destroy
      raise unless professor.save
    end

    remove_column :professors, :user_id, :integer

  end
end
