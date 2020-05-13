class MessagesController < ApplicationController
    # before_action :authorized

    def new 
        @message = Message.new
       
    end

    def create
        @message = Message.create(msg_params)
        if @message.save
            ActionCable.server.broadcast 'room_channel',
                                        content: @message.content, 
                                        sender_id: @message.sender_id , 
                                        receiver_id: @message.receiver_id
                                        # user_name: @message.user_name
        end
    end



    private

    def msg_params
        params.require(:message).permit(:content, :sender_id, :receiver_id)
    end 
end
