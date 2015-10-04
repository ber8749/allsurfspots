class PagesController < ApplicationController
  def index
    @spots = Spot.minimal.approved.has_images.newest.limit(10)
  end
end