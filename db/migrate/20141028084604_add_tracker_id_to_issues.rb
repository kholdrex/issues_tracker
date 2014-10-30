class AddTrackerIdToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :tracker_id, :integer
  end
end
