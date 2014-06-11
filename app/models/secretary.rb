class Secretary < ActiveRecord::Base
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:nusp]
end
