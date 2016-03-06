class Blogo::User < ActiveRecord::Base
  has_many :posts
  has_many :projects, :class_name => 'Blogo::Project'

  has_secure_password

  validates :password, presence: true, on: :create
  validates :name    , presence: true
  validates :email   , presence: true, uniqueness: true
end
