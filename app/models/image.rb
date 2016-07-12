class Image < ActiveRecord::Base
  belongs_to :imageable, polymorphic: true

  dragonfly_accessor :image

  validates :image, presence: true
  validates_size_of :image, maximum: 10.megabytes, message: 'should be no more than 10 MB'
  validates_property :format, of: :image, in: [:jpeg, :jpg, :png, :gif], case_sensitive: false,
                     message: 'should be either .jpeg, .jpg, .png, .gif'

  def stored?
    image_stored?
  end

  def url
    image.url if image_stored?
  end

  def thumb(size)
    image.thumb(size).url if image_stored?
  end

  class << self
    def strong_params
      [:id, :image, :retained_image, :_destroy]
    end
  end

end
