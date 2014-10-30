class CreateListValues < ActiveRecord::Migration
  def change
    create_table :list_values do |t|
      t.string :name
      t.string :default_value
      t.boolean :active

      t.timestamps
    end
  end
end
