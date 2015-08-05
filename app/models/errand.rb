class Errand < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :content, :start_at, :end_at, :project_id,:user_id, presence: true
  paginates_per 10

  scope :this_year, -> {where(created_at: Time.current.beginning_of_year..Time.current.end_of_year)}

  default_scope {order(approve: :asc, issue: :asc)}
end
