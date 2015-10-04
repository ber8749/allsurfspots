json.array!(@spots) do |spot|
  json.extract! spot, :id, :name, :aliases, :description, :continent, :country, :state, :city, :address, :lat,
                      :lng, :wave_direction, :kind, :bottom, :consistency, :quality, :crowd, :access, :tide,
                      :tide_direction, :power, :wind_direction, :swell_direction, :swell_size, :ability, :locals,
                      :paddle_out, :water_quality, :approved
  json.url spot_url spot
end
