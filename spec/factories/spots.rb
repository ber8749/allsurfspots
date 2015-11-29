FactoryGirl.define do
  factory :spot do
    name            'Boneyards'
    aliases         'Old mans'
    description     'Soft left and right reef break. Breaks best on large long period swells'
    continent       'North America'
    country         'United States of America'
    state           'California'
    city            'Encinitas'
    address         '379 West I Street'
    lat             '33.0366939252055'
    lng             '-117.297642454505'
    wave_direction  'left'
    kind            'reef'
    bottom          'reef'
    consistency     'consistent'
    quality         'good'
    crowd           'crowded'
    access          'easy'
    tide            'mid'
    tide_direction  'rising'
    power           '3'
    wind_direction  'east'
    swell_direction 'south,west,north'
    swell_size      'overhead'
    ability         'beginner,intermediate'
    locals          'kooky'
    paddle_out      'normal'
    water_quality   'clean'
    approved        true
    created_by      1
    created_at      Time.current
    updated_at      Time.current
  end

end
