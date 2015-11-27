class Spot < ActiveRecord::Base
  include Rails.application.routes.url_helpers

  belongs_to :user, foreign_key: :created_by
  has_many :images, as: :imageable

  validates_presence_of :name, :continent, :country, :lat, :lng

  before_save :reject_array_blanks

  scope :approved, -> { where(approved: true) }
  scope :has_images, -> { joins(:images).uniq }
  scope :minimal, -> { select(:id,:name,:lat,:lng,:wave_direction,:kind,:city,:state,:country) }
  scope :newest, -> { order(id: :desc) }
  scope :north_to_south, -> { order(lat: :desc) }

  acts_as_commentable
  ratyrate_rateable 'quality'

  # countries with spots
  def self.countries_with_spots
    Spot.approved.pluck(:continent,:country).uniq.group_by(&:first).each do |key,value|
      value.flatten!
      value.delete(key)
    end
  end

  def url
    spot_path(self)
  end

  def as_json(options)
    super(methods: :url)
  end

  private
    def reject_array_blanks
      self.attributes.each do |key,value|
        self[key.to_sym].reject!(&:blank?) if value.is_a?(Array)
      end
    end
end
