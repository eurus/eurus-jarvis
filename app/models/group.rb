class Group < ActiveRecord::Base
  validates :name, :leader, presence: true
end
