class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_newest_spots, :set_newest_comments, :set_newest_images, :set_continents, :set_countries

  private

    def set_newest_spots
      @newest_spots = Spot.approved.last(5).reverse
    end

    def set_newest_comments
      @newest_comments = Comment.last(5).reverse
    end

    def set_newest_images
      @newest_images = Image.approved.last(1).reverse
    end

    def set_continents
      @continents ||= CONTINENTS
    end

    def set_countries
      @countries ||= Spot.valid_countries
    end

    def verify_admin
      if !current_user || !current_user.is_admin?
        redirect_to root_path, error: "You don't have permission to view this page!"
      end
    end

    def find_owner
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
