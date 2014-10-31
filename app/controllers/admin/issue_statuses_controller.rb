class Admin::IssueStatusesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    @issue_statuses = paginator(IssueStatus.all)
  end

  def new
    @issue_status = IssueStatus.new
  end

  def create
    @issue_status = IssueStatus.new(status_params)
    if @issue_status.valid?
      if @issue_status.save
        redirect_to admin_issue_statuses_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@issue_status.errors.messages)
      redirect_to :back
    end
  end

  def edit
    @issue_status = IssueStatus.find(params[:id])
  end

  def update
    @issue_status = IssueStatus.find(params[:id])
    @issue_status.update_attributes(status_params)
    if @issue_status.valid?
      if @issue_status.save
        flash[:success] = t(:success_update)
        redirect_to admin_issue_statuses_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@issue_status.errors.messages)
      redirect_to :back
    end
  end

  def destroy
    @issue_status = IssueStatus.find(params[:id])
    @issue_status.destroy
    redirect_to :back
  end

  private

  def status_params
    params.require(:issue_status).permit(:name)
  end

end
