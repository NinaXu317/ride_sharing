class User < ApplicationRecord
  # attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :confirmable, :recoverable, :database_authenticatable, :registerable, :rememberable, :validatable
  defaults number_of_rating_given: 0, sum_of_rating_given: 0, number_of_rating_received: 0, sum_of_rating_received: 0

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  has_many :availabilities, :through => :posts
  has_many :requests, :through => :makes
  has_many :posts, dependent: :destroy
  has_many :makes, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id
  # has_many :trips, foreign_key: :driver_id
  has_one :vehicle
  scope :is_driver, ->{ where(is_driver: true) }
  scope :is_rider, ->{ where(is_driver: false) }
  has_one_attached :avatar

  # private
  #   def add_default_avatar
  #     unless avatar.attached?
  #       self.avatar.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.jpg")), filename: 'default.jpg', content_type: "image/jpg")
  #     end
  #   end

  # def active_for_authentication?
  #   super && !Vehicle.find_by(user_id: session[:user_id]).nil?
  # end

  # def inactive_message
  #   !Vehicle.find_by(user_id: session[:user_id]).nil? ? super: :account_inactive
  # end
  #
  # def self.find_for_database_authentication warden_condition
  #   conditions = warden_condition.dup
  #   login = conditions.delete(:login)
  #   where(conditions).where(["lower(email) = :value", {
  #       value: login.strip.downcase
  #   }]).first
  # end
  def avatar_attachment_path
    avatar.attached? ? avatar : 'default.png'
  end

  def ratings
    sum_of_rating_received.to_f / number_of_rating_received.to_f
  end

end