class Post < ApplicationRecord
    belongs_to :availability
    belongs_to :user
    after_commit :create_notifications, on: :create

    def self.find_user_id param_id
        puts param_id
        puts param_id.class
        post = Post.find_by(availability_id: param_id.to_i)
        if post.present?
            return post.user_id
        else
            return nil
        end
    end

    private
    def create_notifications
        Notification.create do |notification|
            notification.notify_type = 'post'
            notification.actor = self.user
            notification.user = self.availability.user
            notification.target = self
        end
    end
end
