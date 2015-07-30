class Errand < ActiveRecord::Base
  belongs_to :user
  validates :content, :start_at, :end_at, :project_id,:user_id, presence: true
  paginates_per 10
end
