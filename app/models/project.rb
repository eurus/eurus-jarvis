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
    dict = {done: '完成', :'on going'=>'进行中', :'blue print'=> '计划', pause:'暂停', maintainning:'维护中'}
    dict[status.to_sym]
  end

  def status_class
    dict = {done: 'success', :'on going'=>'info', :'blue print'=> '', pause:'danger', maintainning:'warning'}
    dict[status.to_sym]
  end
end
