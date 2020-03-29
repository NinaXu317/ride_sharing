class User < ApplicationRecord
  # after_commit :add_default_avatar, on: [:create, :update]

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  has_many :posts, dependent: :destroy
  has_many :makes, dependent: :destroy
  has_many :availabilities, :through => :posts
  has_many :requests, :through => :makes
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
  def avatar_attachment_path
    avatar.attached? ? avatar : 'default.png'
  end

end