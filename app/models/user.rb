class User < ActiveRecord::Base
  attr_accessor :login
  USERROLE = %w{ ceo director pm staff intern}
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
  has_many :plans
  has_and_belongs_to_many :projects

  mount_uploader :avatar, AvatarUploader
  paginates_per 10

  scope :ceo, -> { where(role: "ceo") }
  scope :director, -> { where(role: "director") }
  scope :pm, -> { where(role: "pm") }
  scope :stuff, -> { where(role: "stuff") }
  scope :intern, -> { where(role: "intern") }

  def supervisor
    User.find self.supervisor_id rescue nil
  end

  def buddies
    User.where(supervisor_id: self.id)
  end

  def plans_i_can_see
    ids = (User.dfs self).flatten.map(&:id)
    Plan.where(user_id: ids)
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
      res = (User.buddies node).map { |u| User.dfs u }
      res.push node
      return res
    end
  end

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  def self.（╯‵□′）╯︵┻━┻
    ap "Calm Down, Bro"
  end
end
