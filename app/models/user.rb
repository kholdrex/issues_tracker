class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :members
  has_many :projects, through: :members
  has_many :issues, foreign_key: 'assigned_to_id', foreign_key: 'author_id'
  has_many :issues_assigned_to_me, class_name: 'Issue', foreign_key: 'assigned_to_id'
  has_many :issues_created_by_me, class_name: 'Issue', foreign_key: 'author_id'
  has_many :members
  belongs_to :role

  def self.current
    current_user || User.new
  end

  def nickname
    name || email
  end

  def permissions_for_project(project)
    Permission.joins(roles: :members).where(members: { project_id: project.id, user_id: id }) if project.present?
  end

end
