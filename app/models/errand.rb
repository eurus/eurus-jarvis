class Errand < ActiveRecord::Base
  belongs_to :user
  validates :location, :content, :start_at, :end_at, :project_id,:user_id, presence: true
  
end
