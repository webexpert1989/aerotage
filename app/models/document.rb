class Document < ActiveRecord::Base
  belongs_to :documentable, polymorphic: true

  dragonfly_accessor :document do
    storage_options do |attachment|
      { headers: { 'x-amz-acl' => 'private' } }
    end
  end

  validates :document, presence: true
  validates_size_of :document, maximum: 20.megabytes, message: 'should be no more than 20 MB'
  validates_property :mime_type, of: :document, in: %w(application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document), case_sensitive: false,
                     message: 'should be either .pdf, .doc, .docx'

  def stored?
    document_stored?
  end

  def url
    document.url if document_stored?
  end

  def remote_url
    document.remote_url(expires: 1.minute.from_now) if document_stored?
  end

  class << self
    def strong_params
      [:id, :document, :retained_document, :_destroy]
    end
  end

end
