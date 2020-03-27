class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]
  # respond_to :js

  # GET /availabilities
  # GET /availabilities.json
  def index
    @availabilities = Availability.unmatched
  end

  def search
    if params[:search]
      @availabilities = Availability.unmatched.search(params[:search])
      if @availabilities
        render json: @availabilities
      else
        flash.now[:alert] = "Could not find an availability"
        render json: @availabilities
      end
      #   respond_to do |format|
      #     format.js { render partial: 'availabilities/availability_result.html'}
      #   end
      # else
      #   respond_to do |format|
      #     flash.now[:alert] = "Could not find an availability"
      #     format.js { render partial: 'availabilities/availability_result.html'}
      #   end
      # end
    else
      @availabilities = Availability.unmatched
    end
  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
  end

  # GET /availabilities/new
  def new
    @availability = Availability.new
  end

  # GET /availabilities/1/edit
  def edit
  end

  # POST /availabilities
  # POST /availabilities.json
  def create
    @availability = Availability.new(availability_params)

    respond_to do |format|
      if @availability.save
        format.html { redirect_to @availability, notice: 'Availability was successfully created.' }
        format.json { render :show, status: :created, location: @availability }
      else
        format.html { render :new }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /availabilities/1
  # PATCH/PUT /availabilities/1.json
  def update
    respond_to do |format|
      if @availability.update(availability_params)
        format.html { redirect_to @availability, notice: 'Availability was successfully updated.' }
        format.json { render :show, status: :ok, location: @availability }
      else
        format.html { render :edit }
        format.json { render json: @availability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /availabilities/1
  # DELETE /availabilities/1.json
  def destroy
    @availability.destroy
    respond_to do |format|
      format.html { redirect_to availabilities_url, notice: 'Availability was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def availability_params
      params.require(:availability).permit(:start_city, :start_street_address, :end_city, :end_street_address, :trip_time, :lowest_acceptable_price)
    end

    def search_params
      params.require(:search).permit(:start_city, :start_street_address, :trip_date, :end_city, :end_street_address, :trip_time, :lowest_acceptable_price)
    end
end

