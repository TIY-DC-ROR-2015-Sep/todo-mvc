class User < ActiveRecord::Base
  # validates :email, presence: true, uniqueness: true
  validates_presence_of :email
  validates_uniqueness_of :email

  has_many :lists
  has_many :items, through: :lists
end
