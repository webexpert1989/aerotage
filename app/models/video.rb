class Video < ActiveRecord::Base
  belongs_to :videoable, polymorphic: true

  dragonfly_accessor :video

  validates :video, presence: true
  validates_size_of :video, maximum: 20.megabytes, message: 'should be no more than 20 MB'
  validates_property :mime_type, of: :video, in: %w(video/x-flv video/quicktime video/mp4 video/x-msvideo), case_sensitive: false,
                     message: 'should be either .flv, .mov, .mp4, .avi'

  def stored?
    video_stored?
  end

  def url
    video.url if video_stored?
  end

  class << self
    def strong_params
      [:id, :video, :retained_video, :_destroy]
    end
  end

end
