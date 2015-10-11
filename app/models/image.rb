class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  attr_accessor :file_upload

  scope :persisted, -> { where.not(id: nil) }
  scope :approved,  -> { where(approved: true) }

  IMGUR_URL = 'http://i.imgur.com/'

  def file
    "#{imgur_id}.jpg"
  end

  def medium_thumb
    "#{imgur_id}m.jpg"
  end

  def url
    "#{IMGUR_URL}#{file}"
  end

  def medium_thumb_url
    "#{IMGUR_URL}#{medium_thumb}"
  end

  def upload
    #TODO: extract image manipulation
    image = Magick::Image.from_blob(file_upload.read).first
    image.resize_to_fit!(800)
    image.format = 'JPG'

    temp = Tempfile.new('temp')
    image.write(temp.path)

    self.imgur_id = imgur_session.image.image_upload(temp.path).id
    image.destroy!
  end

  # pseudo associations
  def imgur_image
    imgur_session.image.image(imgur_id)
  end

  private
    def imgur_session
      @imgur_session ||= Imgurapi::Session.new(client_id: Rails.application.secrets.imgur['client_id'],
                                            client_secret: Rails.application.secrets.imgur['client_secret'],
                                            access_token: Rails.application.secrets.imgur['access_token'],
                                            refresh_token: Rails.application.secrets.imgur['refresh_token'])
    end
end
