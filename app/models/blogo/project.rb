class Blogo::Project < Blogo::Post
  has_many :attachments, :class_name => 'Blogo::Attachment'
  accepts_nested_attributes_for :attachments, allow_destroy: true

  scope :published, -> { where(published: true).where("published_at <= ?", Time.zone.now).where('type IS NOT NULL') }
end