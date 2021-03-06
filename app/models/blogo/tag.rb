class Blogo::Tag < ActiveRecord::Base
  has_many :taggings
  has_many :posts, through: :taggings

  enum role: [ :post, :project ]

  validates :name, presence: true

  def to_param
    name
  end
end
