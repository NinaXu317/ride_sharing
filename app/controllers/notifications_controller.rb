class NotificationsController < ApplicationController
    skip_before_action :verify_authenticity_token


    def accept
      puts "trigger driver accept ride"
      puts params[:request_id]
      puts current_user.id

      request = Request.find(params[:request_id])
      request.matched_user_id = current_user.id
      request.matched_availability_id = -1
      request.request_status = 'confirmed'
      request.save!

      Trip.create(driver_id: current_user.id,
                  rider_id: Make.find_by(request_id: params[:request_id]).user_id,
                  request_id: params[:request_id],
                  availability_id: -1,
                  status: "confirmed",
                  trip_time: Request.find(params[:request_id]).trip_time)

    end

    def notify
      puts "notify"
      # availability_id = params["availability_id"].to_i
      availability = Availability.find(params[:availability_id])
      post = Post.find_by(availability_id: availability_id)
      user = User.find(post.user_id)
      if params["is_send_notification"] == "false"
        twilio_client = TwilioClient.new
        message = "Ride Sharing: An availability for #{user.username} has been matched.\nThe trip starts at #{availability.start_street_address}, ends at #{availability.end_street_address}.\nThe trip time is #{availability.trip_time}. Text Y to accpet or N to ignore."
        availability.availability_status = "waiting"
        availability.save!
        CurtAvail.create!(availability_id: availability_id, phone_number: user.phone_number)
        twilio_client.send_text(user, message)
      end
    end



    def message
      response = Twilio::TwiML::MessagingResponse.new
      response.message do |message|
        message.body("Hello World!")
      end
      puts params["Body"]
      response_text = params["Body"].downcase!
      response_number = params["From"][2..-1].to_i
      curtAvail = CurtAvail.find_by(phone_number: response_number)
      if !curtAvail.nil?
        availability_id = curtAvail.availability_id
        availability = Availability.find(availability_id)
        if response_text == "y"
          # availability.matched_user_id = User.find_by(phone_number: response_number).id
          availability.matched_user_id = User.find_by(phone_number: response_number).id
          availability.availability_status = "confirmed"
          availability.save
          Trip.create!(driver_id: availability.matched_user_id,
                       rider_id: current_user.id,
                       availability_id: availability_id,
                       trip_time: availability.trip_time,
                       status: "confirmed")
          curtAvail.destroy
        elsif response_text == "n"
          availability.availability_status = "started"
          availability.save
          curtAvail.destroy
        end
      end
      render 'static_pages/home'
    end

end