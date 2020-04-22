class Post < ApplicationRecord
    belongs_to :availability
    belongs_to :user

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
end
