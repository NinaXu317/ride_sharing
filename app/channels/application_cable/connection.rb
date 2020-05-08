module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :curr_user

    def connect
      self.curr_user = find_verified_user
      # logger.add_tags curr_user.id
    end

    protected
    def find_verified_user
      # curr_user = User.find_by(id: cookies.signed['user_id'])
      # puts "connecting action cable...."
      # puts curr_user.nil?
      # # && cookies.signed['user_expires_at'] > Time.now
      # if curr_user
      #   curr_user
      # else
      #   reject_unauthorized_connection
      # end
      if curr_user = env['warden'].user
        curr_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
