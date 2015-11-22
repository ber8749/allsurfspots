CONTINENTS          = Country.all.map { |c| Country.find_by_name(c[0])[1]['continent'] }.uniq.sort
COUNTRIES           = Country.all.map { |c| c[0] }
CONTINENT_COUNTRIES = CONTINENTS.map { |c| { c => Country.find_all_by_continent(c).map { |c1| c1[1]['name'] } } }.reduce(&:merge)
COUNTRY_SPOTS       = Spot.try(:countries_with_spots) # handle case when db has not been created yet
SPOT_OPTIONS        = YAML.load_file('config/spot_options.yml').with_indifferent_access