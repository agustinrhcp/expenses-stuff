require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessor :password

  before_save :encrypt_password

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true
  validates :password, length: { in: 6..20}, on: :create

  has_many :expenses

  def authenticates?(password)
    encrypted_password == BCrypt::Engine.hash_secret(password, salt)
  end

  private

  def encrypt_password
    self.salt = BCrypt::Engine.generate_salt
    self.encrypted_password = BCrypt::Engine.hash_secret(password, salt)
    password = nil
  end
end
