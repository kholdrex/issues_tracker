class Role < ActiveRecord::Base
  has_and_belongs_to_many :permissions
  has_and_belongs_to_many :members

  validates :name, presence: true, uniqueness: true
  validates :permissions, presence: true

end
