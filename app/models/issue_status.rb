class IssueStatus < ActiveRecord::Base
  has_many :issues
  scope :default, -> {where(default_value: true).take(1)}

  validates :name, presence: true, uniqueness: true

end
