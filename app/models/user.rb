class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:nusp]

  include ActiveModel::Validations

  validates :name , presence: true
  validates :nusp , presence: true, inclusion: { in: 10000..100000000 }, uniqueness: true
  validates :email , presence: true
end
