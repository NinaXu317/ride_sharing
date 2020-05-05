class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    # puts current_user
    stream_from "notifications:#{curr_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end
