#encoding: utf-8
class IssuesController < ApplicationController
  before_filter :authenticate_user!
  before_action :find_project
  before_action :before_new_issue, only: [:new]
  before_action :pagination, only: [:index]
  load_and_authorize_resource
  before_filter :load_permissions

  include IssuesHelper

  def index
    @issues = paginator @project.issues
  end

  def new
    before_new_issue
  end

  def create
    @issue = Issue.new(issue_params)
    @issue.project = @project

    if @issue.valid?
      if @issue.save
        redirect_to project_issue_path(@project, @issue)
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@issue.errors.messages)
      redirect_to :back
    end

  end

  def show

  end

  private

  def issue_params
    params.require(:issue).permit(:subject, :description, :issue_status_id, :priority_id, :parent_id, :tracker_id, :assigned_to_id)
  end

end
