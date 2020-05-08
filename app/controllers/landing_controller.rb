class LandingController < ApplicationController
  # before_action :authorized!

  def index
    @message = Message.new

    @sender_id = params['sender_id']
    @receiver_id = params['receiver_id']
  end

  def chat
    
  end
end
