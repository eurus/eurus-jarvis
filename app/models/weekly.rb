class Weekly < ActiveRecord::Base
  belongs_to :user
  validates :sumary, :hope, presence: true
  validates :hope, :sumary, length: { in: 100..800 }
  paginates_per 5
end
