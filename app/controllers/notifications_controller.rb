class NotificationsController < ApplicationController
    skip_before_action :verify_authenticity_token

    def message  
        response = Twilio::TwiML::MessagingResponse.new
        response.message do |message|
          message.body("Hello World!")
        end
        puts params["Body"]
        render 'static_pages/home'
    end

    def notify
      availability_id = params["availability_id"].to_i
      if params["is_send_notification"] == "true"
        puts "True"
      else
        post = Post.find_by(availability_id: availability_id)
        # puts post.id
      end
    end


end