class User < ActiveRecord::Base
  USERROLE = %w{ ceo director pm stuff intern}
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  has_many :errands
  has_many :overtimes
  has_many :vacations
  has_many :weeklies
  has_many :feedbacks
  has_many :articals
  has_and_belongs_to_many :projects

  mount_uploader :avatar, AvatarUploader
  paginates_per 10

  scope :ceo, -> { where(role: "ceo") }
  scope :director, -> { where(role: "director") }
  scope :pm, -> { where(role: "pm") }
  scope :stuff, -> { where(role: "stuff") }
  scope :intern, -> { where(role: "intern") }

  def supervisor
    User.find self.supervisor_id
  end

  def self.all_except(id)
    where.not(id: id)
  end

  def self.buddies(user)
    if user.role == 'ceo'
      where(supervisor_id: [user.id,nil])
    else
      where(supervisor_id: user.id)
    end
  end

  def self.dfs(node)
    if (User.buddies node).count == 0
      return node
    else
      (User.buddies node).map { |u| User.dfs u }
    end
  end



end
