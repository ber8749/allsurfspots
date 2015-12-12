class Spot < ActiveRecord::Base
  belongs_to :user, foreign_key: :created_by
  has_many   :images, as: :imageable

  validates :name, :continent, :country, :lat, :lng, presence: true

  before_save :reject_array_blanks

  scope :approved,       -> { where.not(approved: false) }
  scope :has_images,     -> { joins(:images).uniq }
  scope :minimal,        -> { select('id,name,lat,lng,wave_direction,kind,city,state,country') }
  scope :newest,         -> { order(id: :desc) }
  scope :north_to_south, -> { order(lat: :desc) }

  acts_as_commentable
  ratyrate_rateable 'quality'

  def self.valid_countries
    Spot.approved.pluck(:continent,:country).uniq.group_by(&:first).each do |key,value|
      value.flatten!
      value.delete(key)
    end
  end

  private
    def reject_array_blanks
      self.attributes.each do |key,value|
        self[key.to_sym].reject!(&:blank?) if value.is_a?(Array)
      end
    end
end
