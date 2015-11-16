class Project < ActiveRecord::Base
  validates :name, :content, :status, presence: true
  paginates_per 10
  has_and_belongs_to_many :users
  belongs_to :owner, class_name:'User'
  def self.done
    where(status: "done",
      created_at: Time.current.beginning_of_year..Time.current.end_of_year)
  end

  def status_explain
    # dict = {done: '完成', :'on going'=>'进行中', :'blue print'=> '计划', pause:'暂停', maintainning:'维护中'}
    # dict[status.to_sym]
    status
  end

  def status_class
    dict = {:'收尾'=> 'info', :'执行'=>'success', :'规划'=> 'warning', :'中止'=>'danger', :'启动'=>'', :'维护'=>''}
    dict[status.to_sym]
  end

  def status_no
    dict = {:'收尾'=> 4, :'执行'=>3, :'规划'=> 2, :'中止'=>0, :'启动'=>1, :'维护'=>5}
    dict[status.to_sym]
  end

  def include_uid?(user_id)
    (users.map(&:id) + [owner_id]).include? user_id
  end
end
