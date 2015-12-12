class SpotsController < ApplicationController
  before_action :set_spot, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :country_options, :state_options]

  respond_to :html

  def index
    p = params.slice(:continent,:country,:state).symbolize_keys
    @spots = Spot.minimal.approved.where(p)
    @country = p[:country] ? Country.find_by_name(p[:country])[1] : nil
    if @country
      @spots = @spots.north_to_south
    end
  end

  def show
    @comment = @spot.comments.new
    @image = @spot.images.new
  end

  def new
    @spot = Spot.new
  end

  def edit
    unless  current_user.id == @spot.created_by
      redirect_to @spot, notice: "You don't have permission to edit this spot!"
    end
  end

  def create
    @spot = Spot.new(spot_params.merge(created_by: current_user.id))
    flash[:notice] = 'Spot successfully created.' if @spot.save
    respond_with(@spot)
  end

  def update
    flash[:notice] = 'Spot successfully updated.' if @spot.update(spot_params)
    respond_with(@spot)
  end

  def destroy
    @spot.destroy
    respond_with(@spot)
  end

  def country_options
    @countries = CONTINENT_COUNTRIES[params[:continent]]
  end

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
