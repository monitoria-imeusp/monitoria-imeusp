class Student < ActiveRecord::Base

	include ActiveModel::Validations
	validates :name , presence: true
	validates :password , presence: true
	validates :nusp , presence: true, format: { with: /\A[0-9]{6,9}\z/ }
	validates :gender , presence: true, inclusion: {in: 0..1}
	validates :rg , presence: true
	validates :cpf , presence: true
	validates :adress , presence: true
	validates :district , presence: true
	validates :zipcode , presence: true
	validates :city , presence: true
	validates :state , presence: true
	validates :tel , presence: true, format: { with: /\A[0-9]{10,11}\z/ }
	validates :cel , format: { with: /\A[0-9]{10,11}\z/ }
	validates :email , presence: true

end
