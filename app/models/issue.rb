#encoding: utf-8
class Issue < ActiveRecord::Base

  belongs_to :project
  has_many :subissues, class_name: 'Issue', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Issue', foreign_key: 'parent_id'
  belongs_to :status, class_name: 'IssueStatus', foreign_key: 'issue_status_id'
  belongs_to :priority, class_name: 'IssuePriority', foreign_key: 'priority_id'
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :assigned_to, class_name: 'User', foreign_key: 'assigned_to_id'
  belongs_to :tracker

  validates :subject, presence: true
  validates :status, presence: true,
            inclusion: { in: IssueStatus.all, message: 'Выбран неверный статус.' }

  validates :priority, presence: true,
            inclusion: { in: IssuePriority.all, message: 'Выбран неверный приоритет.'}

  validates :tracker, presence: true,
            inclusion: { in: ->(i){ Tracker.joins(:projects).where(projects: { id: i.project_id }) }, message: 'Выбран неверный трекер.' }

  validates :assigned_to, presence: true,
            inclusion: { in: ->(i){ User.joins(projects: :members).where(projects: {id: i.project_id}) }}



end
