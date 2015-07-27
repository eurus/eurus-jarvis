class Plan < ActiveRecord::Base
  validates :title, :description,
    :status, :cut, :start_at,
    :end_at, presence: true
  validates :status,
    inclusion: { in: %w(ongoing done overtime new),
                 message: "%{value} is not a valid status" }
    validates :cut,
    inclusion: { in: %w(出差 公司),
                 message: "%{value} is not a valid type" }
    validates :description, length: {in: 100..50000}

  belongs_to :user
  paginates_per 10
  after_create :send_it_to_supervisor

  private
  def send_it_to_supervisor
    user = self.user
    ids = User.ceo.map { |e| e.id }.push user.supervisor.id
    sps = User.where(id:ids)
    sps.each do |s|
      NotifyMailer.plan_maker(s, self).deliver_later
    end
  end
end
