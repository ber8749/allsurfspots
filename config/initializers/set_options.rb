CONTINENTS          = Country.all.map { |c| Country.find_by_name(c.first)[1]['continent'] }.uniq.sort
COUNTRIES           = Country.all.map { |c| c.first }
CONTINENT_COUNTRIES = CONTINENTS.map { |c| { c => Country.find_all_by_continent(c).map { |c1| c1[1]['name'] } } }.reduce(&:merge)
SPOT_OPTIONS        = YAML.load_file('config/spot_options.yml').with_indifferent_access