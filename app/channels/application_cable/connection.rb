module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :curr_user

    def connect
      self.curr_user = find_verfied_user
    end

    protected

    def find_verfied_user
      if curr_user = env['warden'].user
        curr_user
      else
        reject_unauthorized_connection
      end
    end
  end
end