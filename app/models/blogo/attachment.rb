class Blogo::Attachment < ActiveRecord::Base
  has_attached_file :file, styles: { medium: '1024x768>', thumb: '400x400>' }
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  belongs_to :project, :class_name => 'Blogo::Project'
end
