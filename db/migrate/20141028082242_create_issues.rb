class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :subject
      t.text :description
      t.integer :status_id
      t.integer :priority_id
      t.integer :assigned_to_id
      t.integer :author_id
      t.integer :parent_id
      t.date :start_date
      t.date :due_date

      t.timestamps
    end
  end
end
