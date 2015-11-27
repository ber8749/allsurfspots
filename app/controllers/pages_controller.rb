class PagesController < ApplicationController

  respond_to :html

  def index
    @spots = Spot.minimal.approved.newest.limit(10)
    respond_with(@spots)
  end
end