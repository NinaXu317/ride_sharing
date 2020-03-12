class VechilesController < ApplicationController
  before_action :set_vechile, only: [:show, :edit, :update, :destroy]

  # GET /vechiles
  # GET /vechiles.json
  def index
    @vechiles = Vechile.all
  end

  # GET /vechiles/1
  # GET /vechiles/1.json
  def show
  end

  # GET /vechiles/new
  def new
    @vechile = Vechile.new
  end

  # GET /vechiles/1/edit
  def edit
  end

  # POST /vechiles
  # POST /vechiles.json
  def create
    @vechile = Vechile.new(vechile_params)

    respond_to do |format|
      if @vechile.save
        format.html { redirect_to @vechile, notice: 'Vechile was successfully created.' }
        format.json { render :show, status: :created, location: @vechile }
      else
        format.html { render :new }
        format.json { render json: @vechile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vechiles/1
  # PATCH/PUT /vechiles/1.json
  def update
    respond_to do |format|
      if @vechile.update(vechile_params)
        format.html { redirect_to @vechile, notice: 'Vechile was successfully updated.' }
        format.json { render :show, status: :ok, location: @vechile }
      else
        format.html { render :edit }
        format.json { render json: @vechile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vechiles/1
  # DELETE /vechiles/1.json
  def destroy
    @vechile.destroy
    respond_to do |format|
      format.html { redirect_to vechiles_url, notice: 'Vechile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vechile
      @vechile = Vechile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def vechile_params
      params.require(:vechile).permit(:user_id, :license_number, :vehicle_make, :vehicle_model, :vehicle_plate)
    end
end
