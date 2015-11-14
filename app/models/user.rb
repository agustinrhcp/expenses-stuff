require 'bcrypt'

class User < ActiveRecord::Base
	attr_accessor :password

	before_save :encrypt_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates_length_of :password, in: 6..20, on: :create

	def self.authenticate(email, password)
		user = User.find_by_email(email)

		if user.encrypted_password == BCrypt::Engine.hash_secret(password, user.salt)
			user
		end
	end

	private

	def encrypt_password
		self.salt = BCrypt::Engine.generate_salt
		self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
		password = nil
	end
end
