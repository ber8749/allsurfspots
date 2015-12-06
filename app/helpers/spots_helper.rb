module SpotsHelper
  def spot_options(key)
    SPOT_OPTIONS[key]
  end

  def continent_options
    [''] + CONTINENTS
  end

  def country_options
    if @spot.persisted?
      CONTINENT_COUNTRIES[@spot.continent]
    else
      [''] + COUNTRIES
    end
  end

  def state_options
    if @spot.persisted?
      c = Country.find_by_name @spot.country
      Country[c[0]].subdivisions.map { |k,v| v['name'] }
    else
      []
    end
  end

  def spots_to_json
    s = []
    if @spot.try(:persisted?)
      s << @spot.attributes.merge(url: spot_url(@spot))
    elsif @spots
      s = @spots.map { |s| s.attributes.merge(url: spot_url(s)) }
    end
    s.to_json.html_safe
  end

  def spot_image_caption(image)
    link_to("#{image.imageable.name}, #{image.imageable.country}", spot_path(image.imageable.id)).gsub('"', "'")
  end
end