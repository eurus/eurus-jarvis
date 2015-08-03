class Weekly < ActiveRecord::Base
  belongs_to :user
  validates :sumary, :hope, presence: true
  validates :hope, :sumary, length: { in: 100..80000 }
  paginates_per 10
end
