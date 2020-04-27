class Make < ApplicationRecord
    belongs_to :user
    belongs_to :request

    def self.find_user_id user_id
        where("user_id = ?", user_id.to_i)
    end
end