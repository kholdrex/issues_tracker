class Admin::RolesController < ApplicationController

  def index
    @roles = paginator(Role.all)
  end

  def new
    @role = Role.new
    @project_permissions = Permission.where( subject_class: 'Project' )
    @issue_permissions = Permission.where( subject_class: 'Issue' )
  end

  def create
    permissions = []
    params[:permissions][:permissions_id].each do |t|
      permissions << Permission.find(t)
    end

    @role = Role.new(role_params)
    @role.permissions = permissions
    @role.save
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

end
