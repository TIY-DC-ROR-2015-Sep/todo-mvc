class List < ActiveRecord::Base
  validates_uniqueness_of :name, scope: :user_id
  validates_presence_of :name, :user_id

  belongs_to :user
  has_many :items
end
