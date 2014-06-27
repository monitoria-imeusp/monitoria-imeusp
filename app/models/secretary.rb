class Secretary < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, 
    :confirmable, :authentication_keys => [:nusp]
end
