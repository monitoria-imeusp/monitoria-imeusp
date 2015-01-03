class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable, :confirmable, :authentication_keys => [:nusp]

  include ActiveModel::Validations

  validates :name , presence: true
  validates :nusp , presence: true, inclusion: { in: 10000..100000000 }, uniqueness: true
  validates :email , presence: true
  has_one :student
  has_one :professor

  def student
    result = Student.where(user_id: id)
    if block_given? and result.any?
      yield result.take
    else
      result.take
    end
  end

  def student?
    Student.where(user_id: id).any?
  end

  def professor
    result = Professor.where(user_id: id)
    if block_given? and result.any?
      yield result.take
    else
      result.take
    end
  end

  def professor?
    Professor.where(user_id: id).any?
  end

  def super_professor?
    query = Professor.where(user_id: id)
    query.any? and query.take.super_professor?
  end
end
