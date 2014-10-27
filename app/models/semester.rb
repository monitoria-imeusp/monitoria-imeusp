class Semester < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :candidature
  validates :year, presence: true
  validates :parity, presence: true, inclusion: {in: 0..1}
  #FIXME for some reason the line below does not work properly, it gives false positives.
  #validates :open, presence: true

  def parity_as_s
    parity == 0 ? "Ímpar" : "Par"
  end

  def parity_as_i
    parity+1
  end

  def open_as_s
    open ? "Aberto" : "Fechado"
  end

  def period_as_s
    year.to_s + "/" + parity_as_i.to_s
  end

  def as_s
    "#{parity+1}º semestre de #{year}"
  end

  def self.all_open
    Semester.where(open: true).all
  end
end
