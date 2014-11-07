class Project < ActiveRecord::Base
  has_many :subprojects, class_name: 'Project', foreign_key: 'parent_id'
  has_many :issues
  has_many :members
  belongs_to :parent, class_name: 'Project'
  has_and_belongs_to_many :trackers

  validates :name, presence: true

  scope :parent_projects, -> { where(parent_id: nil) }

  scope :opened_issues_with_tracker, ->(p, t) { IssueStatus.joins(:issues).select(:issues).where(
      issues: { project_id: p.id, tracker_id: t.id },
      issue_statuses: { closed: false }
  ) }

  scope :all_issues_with_tracker, ->(t) {
      issues.where(tracker_id: t.id)
  ) }

  private

  #scope :opened_issues, ->(p){ joins(trackers: :issues).where(projects: { id: p.id }, trackers: { clesed: false }) }
end
