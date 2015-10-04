require 'test_helper'

class SpotsControllerTest < ActionController::TestCase
  setup do
    @spot = spots(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spots)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spot" do
    assert_difference('Spot.count') do
      post :create, spot: { ability: @spot.ability, access: @spot.access, address: @spot.address, aliases: @spot.aliases, approved: @spot.approved, bottom: @spot.bottom, city: @spot.city, consistency: @spot.consistency, continent: @spot.continent, country: @spot.country, crowd: @spot.crowd, description: @spot.description, direction: @spot.direction, lat: @spot.lat, lng: @spot.lng, locals: @spot.locals, name: @spot.name, paddle_out: @spot.paddle_out, power: @spot.power, quality: @spot.quality, region: @spot.region, state: @spot.state, swell_direction: @spot.swell_direction, swell_size: @spot.swell_size, tide: @spot.tide, tide_direction: @spot.tide_direction, type: @spot.type, type: @spot.type, water_quality: @spot.water_quality, wind_direction: @spot.wind_direction }
    end

    assert_redirected_to spot_path(assigns(:spot))
  end

  test "should show spot" do
    get :show, id: @spot
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spot
    assert_response :success
  end

  test "should update spot" do
    patch :update, id: @spot, spot: { ability: @spot.ability, access: @spot.access, address: @spot.address, aliases: @spot.aliases, approved: @spot.approved, bottom: @spot.bottom, city: @spot.city, consistency: @spot.consistency, continent: @spot.continent, country: @spot.country, crowd: @spot.crowd, description: @spot.description, direction: @spot.direction, lat: @spot.lat, lng: @spot.lng, locals: @spot.locals, name: @spot.name, paddle_out: @spot.paddle_out, power: @spot.power, quality: @spot.quality, region: @spot.region, state: @spot.state, swell_direction: @spot.swell_direction, swell_size: @spot.swell_size, tide: @spot.tide, tide_direction: @spot.tide_direction, type: @spot.type, type: @spot.type, water_quality: @spot.water_quality, wind_direction: @spot.wind_direction }
    assert_redirected_to spot_path(assigns(:spot))
  end

  test "should destroy spot" do
    assert_difference('Spot.count', -1) do
      delete :destroy, id: @spot
    end

    assert_redirected_to spots_path
  end
end
