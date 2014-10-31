class Tracker < ActiveRecord::Base
  has_many :issues
  has_and_belongs_to_many :projects

  validates :name, presence: true

end
