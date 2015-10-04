class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin, only: [:awaiting_approval]

  def spots
    @spots = current_user.spots
  end

  def awaiting_approval
    @spots = Spot.where(approved: nil)
    @images = Image.where(approved: nil)
  end
end