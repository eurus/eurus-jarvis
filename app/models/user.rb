require 'lunar'

class User < ActiveRecord::Base
  attr_accessor :login
  USERROLE = %w{ ceo director pm staff intern}
  OCCUPATION = %w{ office-manager team-leader tech-leader office-assitant }
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
  has_many :owned_projects, foreign_key: 'owner_id', class_name: 'Project'

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

  def fullname
    "#{username.capitalize}#{' '*(10-username.length)}#{realname}"
  end

  def buddies
    if role == 'ceo'
      User.where(supervisor_id: [self.id, nil])
    else
      User.where(supervisor_id: self.id)
    end
  end

  def available_buddies
    if role=='staff' or role=='intern'
      []
    else
      buddies.where(role:['staff', 'intern']) rescue []
    end
  end

  def has_buddy?(uid)
    buddies.map(&:id).include? uid
  end

  def plans_i_can_see
    ids = (User.dfs self).flatten.map(&:id)
    Plan.where(user_id: ids)
  end

  def self.all_except(id)
    where.not(id: id)
  end

  def self.dfs(node)
    if (node.buddies).count == 0
      return [node]
    else
      res = (node.buddies).map { |u| User.dfs u }
      res = res.flatten
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

  def total_fee
    self.errands.this_year.pluck(:fee).reduce(:+).to_i
  end

  def total_errand_day_count
    errands.this_year.map { |e| (e.end_at - e.start_at).to_f }.reduce(:+) || 0
  end

  def role_explain
    dict = {ceo:'CEO', pm:'项目经理', director: '部门主管', staff:'正式员工', intern: '实习生'}
    if occupation.nil?
      dict[role.to_sym]
    else
      occupation
    end
  end

  def ceo?
    role == "ceo"
  end

  def director?
    role == "director"
  end

  def pm?
    role == "pm"
  end

  def staff?
    role == "staff"
  end

  def intern?
    role == "intern"
  end

  def reliability
    sum = self.plans.map { |e| e.diff }.reduce(:+) || 0
    if sum >= 0
      100
    else
      100 + (sum / 3.0).round
    end
  end

  def sabbatical_total
    if join_at
      time_diff = (Date.current - join_at - 365).to_i
      if time_diff > 0
        if time_diff >  360
          6
        else
          year_length = Lunar.lunar_year_length
          d = Lunar.next_spring_festival(join_at+1.years) - (join_at + 1.years)
          return ((d / year_length) * 6).round
        end
      else
        0
      end
    else
      0
    end
  end

  def sabbatical_used
    days = 0
    vacations.where("approve = true and cut = '年假' and created_at <= ? and created_at >= ?",
      Lunar.last_spring_festival,
      Lunar.next_spring_festival).map{|v|
        v.duration
    }.reduce(:+) || 0
  end
end
