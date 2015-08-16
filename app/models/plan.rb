class Plan < ActiveRecord::Base
  validates :title, :description,
    :status, :cut, :start_at,
    :end_at, presence: true

  validates :status,
    inclusion: { in: %w(notbegin ongoing ontime overtime),
                 message: "%{value} is not a valid status" }

  validates :cut,
    inclusion: { in: %w(出差 公司),
                 message: "%{value} is not a valid type" }

  validates :description, length: {in: 40..50000}
  validate :end_should_greater_than_start
  belongs_to :user
  belongs_to :creator, class_name:'User'
  paginates_per 10
  after_create :send_it_to_supervisor

  def self.check_overtime
    all.each do |plan|
      ap "plan id #{plan.id}, this plan suppose to end at #{plan.end_at}"
      #check the plan status
      case plan.status
      when "notbegin","ongoing"
        ap "current status is #{plan.status}"
        plan.status = 'overtime' if plan.end_at < Date.current
      else
        ap "this record is #{plan.status}, skip"
      end
      plan.save
    end
  end

  STATUS_DICT = {ontime:'准时', ongoing:'进行中', notbegin: '未开始', overtime:'延时'}

  def status_explain
    STATUS_DICT[status.to_sym]
  end

  private
  def end_should_greater_than_start
    if self.end_at <  self.start_at
      errors.add("结束时间", "并不能比开始时间小")
    end
  end

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

    if creator and user and creator.try(:id) != user.try(:id)
      NotifyMailer.plan_assigned(user, creator, self).deliver_later
    end
  end
end
