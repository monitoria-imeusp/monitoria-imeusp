class Student < ActiveRecord::Base

	include ActiveModel::Validations
	validates :institute, presence: true
	validates :gender , presence: true, inclusion: {in: 0..1}
	validates :rg , presence: true
	validates :cpf , presence: true
	validates :address , presence: true
	validates :district , presence: true
	validates :zipcode , presence: true
	validates :city , presence: true
	validates :state , presence: true
	validates :tel , presence: true, format: { with: /\A[0-9]{10,11}\z/ }
	validates :cel , format: { with: /\A[0-9]{10,11}\z/ }

	def is_female?
		gender == 0
	end

	def is_male?
		gender == 1
	end
end
