class Artical < ActiveRecord::Base
  belongs_to :user
  validates :title, :content, :user_id, presence: true

  paginates_per 6
end
