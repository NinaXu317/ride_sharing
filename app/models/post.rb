class Post < ApplicationRecord
    belongs_to :availability
    belongs_to :user

    def self.find_user_id param_id
        # puts param_id
        # puts param_id.class
        where("user_id = ?", param_id.to_i)
    end
end
