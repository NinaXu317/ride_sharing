class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :posts, dependent: :destroy
  has_many :makes, dependent: :destroy
  has_many :availabilities, :through => :posts
  has_many :requests, :through => :makes
  has_one :vehicle
end