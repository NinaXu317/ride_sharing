require 'securerandom'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :recoverable, :confirmable
        #  :database_authenticatable, :registerable, :rememberable, :validatable
         

  defaults number_of_rating_given: 0, sum_of_rating_given: 0, number_of_rating_received: 0, sum_of_rating_received: 0
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :availabilities, :through => :posts
  has_many :requests, :through => :makes
  has_many :posts, dependent: :destroy
  has_many :makes, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  has_one :vehicle
  scope :is_driver, ->{ where(is_driver: true) }
  scope :is_rider, ->{ where(is_driver: false) }
  has_one_attached :avatar

  # devise :confirmable
  # validates :phone_number, phone: true
  # private
  #   def add_default_avatar
  #     unless avatar.attached?
  #       self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.jpg")), filename: 'default.jpg', content_type: "image/jpg")
  #     end
  #   end

  def avatar_attachment_path
    avatar.attached? ? avatar : 'default.png'
  end

  def ratings
    sum_of_rating_received.to_f / number_of_rating_received.to_f
  end

end