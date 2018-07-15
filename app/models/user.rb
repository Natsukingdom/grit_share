# Model of User
class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :nickname, presence: true, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 191 }, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true
  has_secure_password
  has_many :pomos
end
