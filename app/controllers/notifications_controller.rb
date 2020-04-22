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
      availability = Availability.find(availability_id)
      post = Post.find_by(availability_id: availability_id)
      puts post.class
      puts post.user_id
      puts post.user_id.class

      user = User.find(post.user_id)
      if params["is_send_notification"] == "true"
        puts "True"
      else
        twilio_client = TwilioClient.new
        message = "\nRide Sharing: An availability for #{user.username} has been matched.\nThe trip starts at #{availability.start_street_address}, ends at #{availability.end_street_address}.\nThe trip time is #{availability.trip_time}. Text Y to accpet or N to ignore."
        twilio_client.send_text(user, message)
      end
    end


end