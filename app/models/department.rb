class Department < ActiveRecord::Base
  has_many :course
  has_many :professor
end
