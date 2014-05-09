class Professor < ActiveRecord::Base
	has_many :request_for_teaching_assistant
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:nusp]
end
