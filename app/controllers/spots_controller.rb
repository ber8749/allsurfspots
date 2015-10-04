class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :country_options, :state_options]

  # GET /spots
  # GET /spots.json
  def index
    p = params.slice(:continent,:country,:state).symbolize_keys
    @spots = Spot.minimal.approved.where(p)
    @country = p[:country] ? Country.find_by_name(p[:country])[1] : nil
    if @country
      @spots = @spots.north_to_south
    end
  end

  # GET /spots/1
  # GET /spots/1.json
  def show
    @comment = @spot.comments.new
    @image = @spot.images.new
  end

  # GET /spots/new
  def new
    @spot = Spot.new
  end

  # GET /spots/1/edit
  def edit
    unless  current_user.id == @spot.created_by
      redirect_to @spot, notice: "You don't have permission to edit this spot!"
    end
  end

  # POST /spots
  # POST /spots.json
  def create
    @spot = Spot.new(spot_params.merge(created_by: current_user.id))

    respond_to do |format|
      if @spot.save
        format.html { redirect_to @spot, notice: 'Spot was successfully created.' }
        format.json { render :show, status: :created, location: @spot }
      else
        format.html { render :new }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /spots/1
  # PATCH/PUT /spots/1.json
  def update
    respond_to do |format|
      if @spot.update(spot_params)
        format.html { redirect_to @spot, notice: 'Spot was successfully updated.' }
        format.json { render :show, status: :ok, location: @spot }
      else
        format.html { render :edit }
        format.json { render json: @spot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /spots/1
  # DELETE /spots/1.json
  def destroy
    @spot.destroy
    respond_to do |format|
      format.html { redirect_to spots_url, notice: 'Spot was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /spots/country_options
  def country_options
    @countries = CONTINENT_COUNTRIES[params[:continent]]
  end

  # GET /spots/state_options
  def state_options
    country = Country.find_by_name(params[:country])
    @states = Country[country[1]['alpha2']].subdivisions.map { |k,v| v['name'] }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_spot
      @spot = Spot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def spot_params
      params.require(:spot).permit(:name, :aliases, :description, :continent, :country, :state, :city, :approved,
                                   :address, :lat, :lng, { wave_direction: [] }, { kind: [] }, { bottom: [] },
                                   { consistency: [] }, { quality: [] }, { crowd: [] }, { access: [] }, { tide: [] },
                                   { tide_direction: [] }, { power: [] }, { wind_direction: [] }, { swell_direction: [] },
                                   { swell_size: [] }, { ability: [] }, { locals: [] }, { paddle_out: [] },
                                   { water_quality: [] })
    end
end
