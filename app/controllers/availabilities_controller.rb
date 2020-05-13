class AvailabilitiesController < ApplicationController
  respond_to :js
  before_action :set_availability, only: [:show, :edit, :update, :destroy]
  # before_action :authorized, only: [:show]
  before_action :authenticate_user!

  # GET /availabilities
  # GET /availabilities.json
  def index
    @availabilities = Availability.unmatched
  end

  def search
    if params[:search]
      @availabilities = Availability.unmatched.search(params[:search])
      if @availabilities.nil?
        flash.now[:alert] = "Could not find an availability"
      else
        @availabilities = @availabilities.page(params[:page])
      end
      respond_to do |format|
        format.js
        format.html
      end
    else 
      @availabilities = Availability.unmatched.page(params[:page])
      # respond_with @availabilities
      respond_to do |format|
        format.js
        format.html
      end
    end
  end

  # GET /availabilities/1
  # GET /availabilities/1.json
  def show
    user_id = Post.find_user_id_by_availability_id(params[:id])
    driver = nil
    if !user_id.nil?
      driver = User.find_by(id: user_id)
      render 'show', :locals => { :driver => driver } 
    end
  end

  def requestModal
    respond_to do |format|
      format.html
      format.js
    end
  end

  def match
    @availability = Availability.find(params[:id])
    @availability.matched_user_id = current_user.id
    @availability.matched_request_id = -10
    @availability.availability_status = "waiting"
    if @availability.save
      respond_to do |format|
        format.html
        format.js
      end
    else
      flash.now["danger"] = "Request not made"
    end
  end

  # GET /availabilities/new
  def new
    if !Vehicle.find_by(user_id: current_user.id).nil? && !current_user.phone_number.nil?
      @user = User.find(current_user.id)
      @availability = Availability.new
    else
      flash[:error] = "You have to submit your vehicle information and phone number in Profile tab to continue."
      redirect_to root_path
    end

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
        post = Post.create!(user_id: current_user.id, availability_id: @availability.id)
        user = User.find(current_user.id)
        user.posts << post
        @availability.posts << post
        @post_id = post.id
        format.html { redirect_to  user_availability_path(current_user, @availability), notice: 'Availability was successfully created.' }
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
      params.require(:search).permit(:start_street_address, :trip_time, :end_street_address, :trip_time, :lowest_acceptable_price)
    end
end

