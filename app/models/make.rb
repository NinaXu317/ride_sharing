class Make < ApplicationRecord
    belongs_to :user
    belongs_to :request

    def self.find_user_id user_id
        where("user_id = ?", user_id.to_i)
    end

    def self.find_user_id_by_request_id request_id
        make = Make.find_make_by_request(request_id)
        if make.empty?
            return nil
        else
            return make[0].user_id
        end
    end

    def self.find_make_by_request request_id
        where("request_id = ?", request_id.to_i)
    end
end