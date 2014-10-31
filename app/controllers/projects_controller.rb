#encoding: utf-8
class ProjectsController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_project, except: [:index, :new, :create]
  load_and_authorize_resource
  before_filter :load_permissions
  skip_load_resource :only => [:create]

  def index
    @projects = Project.parent_projects
  end

  def new
    @project = Project.new
    @projects = Project.all
  end

  def create
    @project = Project.new(project_params)
    if @project.valid?
      if @project.save
        redirect_to @project
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@project.errors.messages)
      redirect_to :back
    end
  end

  def show
  end

  def update
    trackers = []
    params[:trackers].each{|t| trackers << Tracker.find(t)} unless params[:trackers].empty?
    @project.trackers = trackers
    @project.update_attributes(project_params)
    if @project.valid?
      if @project.save
        flash[:success] = 'Обновление успешно.'
      else
        flash[:error] = 'Not save'
      end
    else
      flash[:error] = get_errors(@project.errors.full_messages)
    end
    redirect_to :back

  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :parent_id)
  end

end
