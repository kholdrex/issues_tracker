require 'helper_methods'
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :find_project, :is_active?, :get_errors, :pagination, :paginator, :current_member, :is_admin
  include HelperMethods

  rescue_from CanCan::AccessDenied do |exception|
    flash[:alert] = "Access denied. You are not authorized to access the requested page."
    render_permission_denied
  end

  def find_project
    @project = if params[:project_id].present?
                 Project.find(params[:project_id])
               else
                 Project.find(params[:id])
               end
  end

  def is_admin
    current_user.is_admin?
  end

  def pagination
    @page = params[:page]
    session[:per_page] = params[:per_page] if params[:per_page].present?
    @per_page = session[:per_page] || 10
  end

  def paginator(collection)
    result = collection.paginate(:page => @page, :per_page => @per_page)
    result = collection.paginate(:page => 1, :per_page => @per_page) if result.empty?
    return result
  end

  def render_permission_denied
    render :template => 'error_pages/permission_denied', :status => :forbidden
  end
  protected

  #derive the model name from the controller. egs UsersController will return User
  def self.permission
    return name = self.name.gsub('Controller','').singularize.split('::').last.constantize.name rescue nil
  end

  def current_ability
    @current_ability ||= Ability.new(current_user, @project)
  end

  #load the permissions for the current user so that UI can be manipulated
  def load_permissions
    @current_permissions = current_user.permissions_for_project(@project)
  end

end
