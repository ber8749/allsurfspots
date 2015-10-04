class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  scope :persisted, -> { where.not(id: nil) }
  scope :approved,  -> { where(approved: true) }

  mount_uploader :image, ImageUploader
end
