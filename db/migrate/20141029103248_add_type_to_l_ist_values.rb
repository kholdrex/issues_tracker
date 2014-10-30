class AddTypeToLIstValues < ActiveRecord::Migration
  def change
    add_column :list_values, :type, :string
  end
end
