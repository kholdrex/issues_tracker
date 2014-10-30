class RemoveRoleIdFromMembers < ActiveRecord::Migration
  def change
    remove_column :members, :role_id
  end
end
