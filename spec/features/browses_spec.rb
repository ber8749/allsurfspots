require 'rails_helper'

feature 'Browses' do
  context 'Contacts' do
    it 'all' do
      visit contacts_path
    end
  end

  context 'Pages' do
    it 'home' do
      visit root_path
    end
  end

  context 'Spots' do
    @spot = FactoryGirl.create(:spot)

    it 'one' do
      visit spots_path(@spot)
    end

    it 'all' do
      visit spots_path
    end

    it 'in United States' do
      visit spots_path(country: 'United States')
    end

    it 'in North Carolina' do
      visit spots_path(state: 'North Carolina')
    end
  end
end
