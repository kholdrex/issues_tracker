class ChangeListValuesDefaultValueType < ActiveRecord::Migration
  def change
    remove_column :list_values, :default_value
    add_column :list_values, :default_value, :boolean, default: false
  end
end
