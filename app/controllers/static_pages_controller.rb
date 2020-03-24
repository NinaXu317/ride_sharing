class StaticPagesController < ApplicationController
  def home
  end

  def about
  end

  def help
  end

  def search
    @availabilities = Availability.unmatched
    # @search = params[:search]
    # if @search.present?
      # @city = @search[:start_city]
      # @availabilities = Availability.where(start_city: @city)
    # end
  end
end
