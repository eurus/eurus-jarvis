class Project < ActiveRecord::Base
  validates :name, :content, :status, presence: true
  paginates_per 10
  has_and_belongs_to_many :users
end
