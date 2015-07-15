class Group < ActiveRecord::Base
  validates :name, :leader, presence: true
  paginates_per 10
  serialize :id_array
end
