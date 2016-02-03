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
	belongs_to :user

	def name
		self[:name] or user.name
	end

	def nusp
		self[:nusp] or user.nusp
	end

	def email
		self[:email] or user.email
	end

	def institute
		if self[:institute] == "Outro"
			self[:institute_text]
		else
			self[:institute]
		end
	end

	def is_female?
		gender == 0
	end

	def is_male?
		gender == 1
	end

	def gender_as_s
		if gender == 0
			"Feminino"
		else
			"Masculino"
		end
	end

	def user
		User.find(user_id)
	end

	def history_table
		auth = {username: ENV["HISTORY_AUTH_USERNAME"], password: ENV["HISTORY_AUTH_PASSWORD"]}
		begin
			JSON.parse(HTTParty.get("#{ENV['HISTORY_REQUEST_URL']}#{nusp}", basic_auth: auth, timeout: 5).body.encode("UTF-8"))
		rescue
			""
		end
	end


end
