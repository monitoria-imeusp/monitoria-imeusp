class Candidature < ActiveRecord::Base
  include ActiveModel::Validations
  validates :time_period_preference, presence: true
  validates :course1_id, presence: true
  belongs_to :student
end
