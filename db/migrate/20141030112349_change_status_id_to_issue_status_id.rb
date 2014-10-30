class ChangeStatusIdToIssueStatusId < ActiveRecord::Migration
  def change
    rename_column :issues, :status_id, :issue_status_id
  end
end
