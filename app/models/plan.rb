class Plan < ActiveRecord::Base
  validates :title, :description,
    :status, :cut, :start_at,
    :end_at, presence: true
  validates :status,
    inclusion: { in: %w(ongoing done overtime),
                 message: "%{value} is not a valid status" }
   validates :cut,
    inclusion: { in: %w(出差 公司),
                 message: "%{value} is not a valid type" }
  validates :description, length: {in: 100..50000}

  belongs_to :user
  paginates_per 10
end
