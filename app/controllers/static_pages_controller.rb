class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def help
  end

  def search
    @availability = Availability.new
  end
end
