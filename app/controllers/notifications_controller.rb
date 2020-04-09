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
end