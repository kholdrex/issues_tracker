class CreateIssueStatuses < ActiveRecord::Migration
  def change
    create_table :issue_statuses do |t|
      t.string :name
      t.boolean :default_value
      t.boolean :closed

      t.timestamps
    end
  end
end
