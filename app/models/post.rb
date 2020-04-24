class Post < ApplicationRecord
    belongs_to :availability
    belongs_to :user

    def self.find_user_id user_id
        where("user_id = ?", user_id.to_i)
    end

    def self.find_user_id_by_availability_id availability_id
        post = Post.find_post_by_availability(availability_id)
        if post.empty?
            return nil
        else
            return post[0].user_id
        end
    end

    def self.find_post_by_availability availability_id
        where("availability_id = ?", availability_id.to_i)
    end

end
