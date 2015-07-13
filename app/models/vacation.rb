class Vacation < ActiveRecord::Base
  belongs_to :user
  validates :duration, numericality: { greater_than_or_equal_to: 0.5}
  validates :start_at, :duration, :cut, :content, :user_id, presence: true
  paginates_per 10
end
