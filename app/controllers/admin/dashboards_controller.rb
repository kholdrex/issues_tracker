class Admin::DashboardsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :is_admin

  def index
  end
end
