class IssueStatus < ActiveRecord::Base
  has_many :issues
  scope :default, -> {where(default_value: true).take(1)}
end
