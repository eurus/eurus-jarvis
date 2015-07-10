class Project < ActiveRecord::Base
  validates :name, :content, :status, presence: true
  paginates_per 10
end
