require 'rails_helper'

describe Spot do
  describe '.valid_countries' do
    context 'when there are spots' do
      it 'returns countries by continent' do
        spot = create(:spot)
        result = Spot.valid_countries
        expect(result).to eq(spot.continent => [spot.country])
      end
    end
    context 'where there are not any spots' do
      it 'returns an empty hash' do
        result = Spot.valid_countries
        expect(result).to eq({})
      end
    end
  end
end
