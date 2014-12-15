class Advise < ActiveRecord::Base
  validates :title, presence: true
  validates :message, presence: true
  validates :order, presence: true
end
