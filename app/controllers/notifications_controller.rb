class NotificationsController < ApplicationController
    skip_before_action :verify_authenticity_token
    include NotificationsHelper


    def accept
      puts "trigger driver accept ride"
      # puts params[:request_id]
      # puts current_user.id

      request = Request.find(session[:request_id])
      request.matched_user_id = current_user.id
      request.matched_availability_id = -1
      request.request_status = 'confirmed'
      request.save!
      #
      # @trip = Trip.create(driver_id: current_user.id,
      #             rider_id: Make.find_by(request_id: params[:request_id]).user_id,
      #             request_id: params[:request_id],
      #             availability_id: -1,
      #             status: "confirmed",
      #             trip_time: Request.find(params[:request_id]).trip_time)

      @trip = Trip.new(driver_id: current_user.id,
                          rider_id: Make.find_by(request_id: session[:request_id]).user_id,
                          request_id: session[:request_id],
                          availability_id: -1,
                          status: "confirmed",
                          trip_time: Request.find(session[:request_id]).trip_time)
      session[:request_id] = nil

      respond_to do |format|
        if @trip.save
          format.html { redirect_to search_user_requests_path, notice: 'You accept the request successfully.' }

        else
          format.html { redirect_to search_user_requests_path, notice: "The request cannot be accepted. Try again."}
        end
      end
    end

    def notify
      puts "notify driver"
      availability = Availability.find(session[:availability_id])
      post = Post.find_by(availability_id: availability.id)
      user = User.find(post.user_id)
      twilio_client = TwilioClient.new
      message = nil
      if availability.matched_request_id < 0
        message = "Ride Sharing: An availability for #{user.username} has been matched.\nThe trip starts at #{availability.start_street_address}, ends at #{availability.end_street_address}.\nThe trip time is #{availability.trip_time}. Text Y to accpet or N to ignore."
      else
        request = Request.find(availability.matched_request_id)
        message = "Ride Sharing: An availability for #{user.username} has been matched.\nThe trip starts at #{request.start_street_address}, ends at #{request.end_street_address}.\nThe trip time is #{request.trip_time}. Text Y to accpet or N to ignore."
      end
      availability.availability_status = "waiting"
      availability.save!
      CurtAvail.create!(availability_id: availability.id, phone_number: user.phone_number)
      twilio_client.send_text(user, message)
      session[:availability_id] = nil
      respond_to do |format|
        if @trip.save
          format.html { redirect_to search_user_requests_path, notice: 'You accept the request successfully.' }
        else
          format.html { redirect_to search_user_requests_path, notice: "The request cannot be accepted. Try again."}
        end
      end
    end

    def notify_trip_cancel
      tc = TwilioClient.new
      trip_id = params[:trip_id]
      trip = Trip.find(trip_id)
      rider = User.find(trip.rider_id)
      driver = User.find(trip.driver_id)
      if trip.status != "canceled"
        send_cancellation_message(tc, rider, driver, trip)
        trip.status = "canceled"
        trip.save
      end
    end

    def notify_rider
      tc = TwilioClient.new
      rider_id = params[:rider_id]
      rider = User.find(rider_id)
      type = params[:message_type]
      txt = find_messages(type)
      tc.send_text(rider, txt)
    end

    def notify_driver
      tc = TwilioClient.new
      driver_id = params[:driver_id]
      driver = User.find(driver_id)
      type = params[:message_type]
      txt = find_messages_rider(type)
      tc.send_text(driver, txt)
    end

    def call_driver
      driver = User.find(params[:driver_id])
      tc = TwilioClient.new
      tc.call_user(driver)
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
          # availability.matched_user_id = User.find_by(phone_number: response_number).id
          availability.availability_status = "confirmed"
          availability.save
          post = Post.find_by(availability_id: availability_id)
          if availability.matched_request_id < 0
            Trip.create!(driver_id: post.user_id,
                         rider_id: availability.matched_user_id,
                         availability_id: availability.id,
                         request_id: -1,
                         trip_time: availability.trip_time,
                         status: "confirmed")
          else
            request = Request.find(availability.matched_request_id)
            Trip.create!(driver_id: post.user_id,
                         rider_id: availability.matched_user_id,
                         availability_id: availability.id,
                         request_id: request.id,
                         trip_time: request.trip_time,
                         status: "confirmed"
                         )
          end
          curtAvail.destroy
        elsif response_text == "n"
          if availability.matched_request_id > 0
            request = Request.find(availability.matched_request_id)
            request.matched_user_id = -1
            request.matched_availability_id = -1
            request.request_status = "started"
            request.save!
          end
          availability.matched_user_id = -1
          availability.matched_request_id = -1
          availability.availability_status = "started"
          availability.save!
          curtAvail.destroy
        end
      end
      render 'static_pages/home'
    end

end