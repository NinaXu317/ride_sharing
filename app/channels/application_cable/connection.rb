module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
      logger.add_tags current_user.id
    end

    protected
    def find_verified_user
      current_user = User.find_by(id: cookies.signed['user_id'])
      puts "connecting action cable...."
      puts current_user.nil?
      # && cookies.signed['user_expires_at'] > Time.now
      if current_user
        current_user
      else
        reject_unauthorized_connection
      end
    end
  end
end
