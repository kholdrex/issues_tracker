class Admin::RolesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

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
    perm_arr = if params[:permissions].present?
                 params[:permissions][:permissions_id]
               end || []

    perm_arr.each do |t|
      permissions << Permission.find(t)
    end

    @role = Role.new(role_params)
    @role.permissions = permissions

    if @role.valid?
      if @role.save
        flash[:notice]
        redirect_to admin_roles_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@role.errors.messages)
      redirect_to :back
    end
  end

  def edit
    @role = Role.find(params[:id])
    @project_permissions = Permission.where( subject_class: 'Project' )
    @issue_permissions = Permission.where( subject_class: 'Issue' )
  end

  def update
    permissions = []
    perm_arr = if params[:permissions].present?
                 params[:permissions][:permissions_id]
               end || []

    perm_arr.each do |t|
      permissions << Permission.find(t)
    end

    @role = Role.find(params[:id])
    @role.update_attributes(role_params)
    @role.permissions = permissions

    if @role.valid?
      if @role.save
        flash[:success] = t(:success_update)
        redirect_to admin_roles_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@role.errors.messages)
      redirect_to :back
    end
  end

  def destroy
    @role = Role.find(params[:id])
    @role.destroy
    redirect_to :back
  end

  private

  def role_params
    params.require(:role).permit(:name)
  end

end
