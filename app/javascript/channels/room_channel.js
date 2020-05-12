import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    console.log('yiha we are live!')
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("data.sender_id: " + data.sender_id)
    console.log("data-current-user-id: "+$('form label').attr("data-current-user-id"))
    // var sender = data.sender_id
    // var receiver = $( "#message_receiver_id" ).val()
    const myId = $('form label').attr("data-current-user-id");
    console.log('myid'+myId)
    // if (myId) {      
    
    if (data.sender_id == myId || data.receiver_id == myId){
      if (data.sender_id == myId){
        $('#message_holder').append('<div class="message" style="color: #ffffff;text-align:right;font-size:20px;border: 2px solid #dedede; background-color: blue;border-radius: 5px;padding: 10px;margin: 5% 5% 1% 5%;">' 
        +data.content+'</div>'+'<i class="fas fa-paper-plane large" style="font-size: 3em"></i>' )
      }
      else {
        $('#message_holder').append('<div class="message" style="text-align:left; font-size:20px;border: 2px solid #dedede; background-color: f1f1f1;border-radius: 5px;padding: 10px;margin: 5% 5% 1% 5%;">'+data.content+'</div>')
      }
    }
    
    console.log("!!!"+ data.sender_id)
    // Called when there's incoming data on the websocket for this channel
  }
});

var submit_messages;

$(document).on('turbolinks:load', function(){


    submit_messages()
})

submit_messages = function(){

    $('#message_content').on('keydown', function(event){

        if(event.keyCode === 13){

            $('input').click()
            event.target.value = ''
            event.preventDefault()
            console.log('yes we hitted enter!')
        }

    })
}