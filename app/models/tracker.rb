class Tracker < ActiveRecord::Base
  has_many :issues
  has_and_belongs_to_many :projects
end
