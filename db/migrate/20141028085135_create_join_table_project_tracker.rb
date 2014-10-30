class CreateJoinTableProjectTracker < ActiveRecord::Migration
  def change
    create_join_table :projects, :trackers do |t|
       t.index [:project_id, :tracker_id]
       t.index [:tracker_id, :project_id]
    end
  end
end
