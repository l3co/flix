class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  has_many :favorites, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, length: { minimum: 10, allow_blank: true }
end
