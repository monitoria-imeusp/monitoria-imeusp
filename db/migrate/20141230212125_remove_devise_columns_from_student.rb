class RemoveDeviseColumnsFromStudent < ActiveRecord::Migration
  def up

    add_column :students, :user_id, :integer

    Student.all.each do |student|
      user = User.new(email: student.email, password: "placeholder phony fake", encrypted_password: student.encrypted_password, remember_created_at: student.remember_created_at, sign_in_count: student.sign_in_count, current_sign_in_at: student.current_sign_in_at, last_sign_in_at: student.last_sign_in_at, current_sign_in_ip: student.current_sign_in_ip, last_sign_in_ip: student.last_sign_in_ip, confirmation_token: nil, confirmed_at: student.confirmed_at, confirmation_sent_at: student.confirmation_sent_at, unconfirmed_email: nil, nusp: student.nusp, name: student.name)
      unless user.valid?
        print user.errors.messages
        print user.nusp
        raise
      end
      user.save
      student.user_id = user.id
      unless student.valid?
        print student.errors.messages
        print student.nusp
        raise
      end
      student.save
    end

    #### Devise columns
    ## Database authenticatable
    remove_column :students, :password, :string
    remove_column :students, :encrypted_password, :string

    ## Recoverable
    remove_column :students, :reset_password_token, :string
    remove_column :students, :reset_password_sent_at, :datetime

    ## Rememberable
    remove_column :students, :remember_created_at, :datetime

    ## Trackable
    remove_column :students, :sign_in_count, :integer
    remove_column :students, :current_sign_in_at, :datetime
    remove_column :students, :last_sign_in_at, :datetime
    remove_column :students, :current_sign_in_ip, :string
    remove_column :students, :last_sign_in_ip, :string

    ## Confirmable
    remove_column :students, :confirmation_token, :string
    remove_column :students, :confirmed_at, :datetime
    remove_column :students, :confirmation_sent_at, :datetime
    remove_column :students, :unconfirmed_email, :string

    #### Common columns
    remove_column :students, :name, :string
    remove_column :students, :email, :string
    remove_column :students, :nusp, :integer

  end

  def down

    #### Devise columns
    ## Database authenticatable
    add_column :students, :encrypted_password, :string

    ## Recoverable
    add_column :students, :reset_password_token, :string
    add_column :students, :reset_password_sent_at, :datetime

    ## Rememberable
    add_column :students, :remember_created_at, :datetime

    ## Trackable
    add_column :students, :sign_in_count, :integer
    add_column :students, :current_sign_in_at, :datetime
    add_column :students, :last_sign_in_at, :datetime
    add_column :students, :current_sign_in_ip, :string
    add_column :students, :last_sign_in_ip, :string

    ## Confirmable
    add_column :students, :confirmation_token, :string
    add_column :students, :confirmed_at, :datetime
    add_column :students, :confirmation_sent_at, :datetime
    add_column :students, :unconfirmed_email, :string

    #### Common columns
    add_column :students, :name, :string
    add_column :students, :email, :string
    add_column :students, :nusp, :integer


    Student.all.each do |student|
      user = User.find(student.user_id)
      student.email = user.email
      student.encrypted_password = user.encrypted_password
      student.remember_created_at = user.remember_created_at
      student.sign_in_count = user.sign_in_count
      student.current_sign_in_at = user.current_sign_in_at
      student.last_sign_in_at = user.last_sign_in_at
      student.current_sign_in_ip = user.current_sign_in_ip
      student.last_sign_in_ip = user.last_sign_in_ip
      student.confirmation_token = user.confirmation_token
      student.confirmed_at = user.confirmed_at
      student.confirmation_sent_at = user.confirmation_sent_at
      student.unconfirmed_email = user.unconfirmed_email
      student.nusp = "#{user.nusp}"
      student.name = user.name
      user.destroy
      raise unless student.save
    end

    remove_column :students, :user_id, :integer

  end
end
