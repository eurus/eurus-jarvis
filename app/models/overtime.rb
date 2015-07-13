class Overtime < ActiveRecord::Base
  belongs_to :user
  validates :start_at, :duration, :content, :project_id, presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0.5}
  paginates_per 10
end
