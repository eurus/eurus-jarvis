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

  def self.check_overtime
    all.each do |plan|
      ap "plan id #{plan.id}, this plan suppose to end at #{plan.end_at}"
      #check the plan status
      case plan.status
      when "done"
        ap "plan id #{plan.id}, this plan's status is done, skip"
      when "overtime"
        ap "plan id #{plan.id}, this plan's status is overtime, skip"
      else
        if plan.end_at > Date.current
          plan.status = "overtime"
          plan.save
        else
          ap "plan id #{plan.id}, this plan's status is #{plan.status}, but skip"
        end
      end
    end
  end

  private
  def send_it_to_supervisor
    user = self.user
    if user.supervisor
      ids = User.ceo.map { |e| e.id }.push user.supervisor.id if user
    else
      ids = User.ceo.map { |e| e.id }
    end

    sps = User.where(id:ids)
    sps.each do |s|
      NotifyMailer.plan_maker(s, self).deliver_later
    end
  end
end
