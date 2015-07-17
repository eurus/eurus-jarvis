class Weekly < ActiveRecord::Base
  belongs_to :user
  validates :sumary, :hope, presence: true
end
