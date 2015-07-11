class Vacation < ActiveRecord::Base
  belongs_to :user
  validates :start_at, :duration, :cut, :content, :user_id, presence: true

end
