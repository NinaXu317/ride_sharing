class LandingController < ApplicationController
  before_action :authorized

  def index
    @message = Message.new
  end

  def chat
    
  end
end
