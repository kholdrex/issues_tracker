class Admin::TrackersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
    @trackers = paginator(Tracker.all)
  end

  def new
    @tracker = Tracker.new
  end

  def create
    @tracker = Tracker.new(tracker_params)
    if @tracker.valid?
      if @tracker.save
        redirect_to admin_trackers_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@tracker.errors.messages)
      redirect_to :back
    end
  end

  def edit
    @tracker = Tracker.find(params[:id])
  end

  def update
    @tracker = Tracker.find(params[:id])
    @tracker.update_attributes(tracker_params)
    if @tracker.valid?
      if @tracker.save
        flash[:success] = t(:success_update)
        redirect_to admin_trackers_path
      else
        flash[:error] = 'Not save'
        redirect_to :back
      end
    else
      flash[:error] = get_errors(@tracker.errors.messages)
      redirect_to :back
    end
  end

  def destroy
    @tracker = Tracker.find(params[:id])
    @tracker.destroy
    redirect_to :back
  end

  private

  def tracker_params
    params.require(:tracker).permit(:name)
  end

end
