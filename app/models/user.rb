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

  scope :ceo, -> { where(occupation: "ceo") }
  scope :director, -> { where(occupation: "director") }
  scope :pm, -> { where(occupation: "pm") }
  scope :stuff, -> { where(occupation: "stuff") }
  scope :intern, -> { where(occupation: "intern") }

  def self.all_except(id)
    where.not(id: id)
  end

end
