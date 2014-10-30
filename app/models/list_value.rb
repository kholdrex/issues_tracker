class ListValue < ActiveRecord::Base
  has_many :issues
end

class DocumentCategory < ListValue
end

class IssueActivity < ListValue
end