class StaticPagesController < ApplicationController
  def home
    # head :ok
    render status: 200
    # render head :ok
  end

  def about
  end

  def help
  end

end
