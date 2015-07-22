class Plan < ActiveRecord::Base
  validates :title, :description,
    :status, :cut, :start_at,
    :end_at, presence: true
  validates :status,
    inclusion: { in: %w(ongoing done overtime),
                 message: "%{value} is not a valid status" }
  validates :description, length: {in: 100..500}
  
  belongs_to :user
  paginates_per 10
end
