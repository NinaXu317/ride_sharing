class Post < ApplicationRecord
    belongs_to :availability
    belongs_to :user

    def self.find_user_id param_id
        post_id = where("availability_id = ?", "#{param_id}".to_i)
        if post_id.present?
            return Post.find(:id => post_id).user_id
        end
        return nil
    end
end
