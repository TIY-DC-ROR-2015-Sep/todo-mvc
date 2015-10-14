class Item < ActiveRecord::Base
  validates_presence_of :name, :list_id
  validates_uniqueness_of :name, scope: :list_id
  
  belongs_to :list
end
