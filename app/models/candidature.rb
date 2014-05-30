class Candidature < ActiveRecord::Base
  include ActiveModel::Validations
  validates :avaliability_daytime, presence: true
  validates :avaliability_night_time, presence: true
  validates :time_period_preference, presence: true
  validates :course1_id, presence: true
  belongs_to :student
end
