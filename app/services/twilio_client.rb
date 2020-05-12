class TwilioClient
    attr_reader :TwilioClient

    def initialize
        @client = Twilio::REST::Client.new account_sid, auth_token
    end


    def send_text(user, message)
        @client.messages.create(
            to: user.phone_number,
            from: phone_number,
            body: message,
            )
    end

    def call_user(user)
        @client.calls.create(
            to: user.phone_number,
            from: phone_number,
            url: 'http://demo.twilio.com/docs/voice.xml' # Fetch instructions from this URL when the call connects
            )
    end
    #
    # def send_text(user, message, availability_id)
    #     service = @client.messaging.services.create(friendly_name: availability_id)
    #     @client.messages.create(
    #         to: user.phone_number,
    #         from: phone_number,
    #         body: message,
    #     )
    # end
    private
        def account_sid
            Rails.application.credentials.twilio[:account_sid]
        end

        def auth_token
            Rails.application.credentials.twilio[:auth_token]
        end

        def phone_number
            12565988581
        end
end