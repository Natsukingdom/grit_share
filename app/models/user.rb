# Model of User
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  before_save { email.downcase! }
  validates :nickname, presence: true, length: { maximum: 100 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    length: { maximum: 191 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, length: { minimum: 6 }, presence: true
  has_many :pomos
  enum authority: { general: 0, admin: 1 }
end
