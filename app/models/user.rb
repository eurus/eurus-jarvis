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
end
