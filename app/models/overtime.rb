class Overtime < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :start_at, :duration, :content,presence: true
  validates :duration, numericality: { greater_than_or_equal_to: 0.5}
  paginates_per 10

  default_scope {order(approve: :asc, issue: :asc)}
end
