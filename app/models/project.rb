class Project < ActiveRecord::Base
  validates :name, :content, :status, presence: true
  paginates_per 10
  has_and_belongs_to_many :users

  def self.done
    where(status: "done",
      created_at: Time.current.beginning_of_year..Time.current.end_of_year)
  end
end
