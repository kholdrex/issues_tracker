class SettingsController < ApplicationController
  before_action :find_project
  include ApplicationHelper

  def index
  end

  def info
    @projects = Project.all
    @trackers = Tracker.all
  end

  def modules

  end

  def activities

  end

  def members
    @users = User.all
    @roles = Role.all
  end

  def add_members
    @members = []
    params[:members][:user_ids].each do |t|
      user = User.find(t)
      member = Member.new(user: user)
      params[:members][:role_ids].each do |r|
        member.roles << Role.find(r)
      end
      @members << member
      @project.members << member
    end
    @project.save
    render partial: 'settings/members', collection: @members
  end

  def remove_member
    Member.destroy(params[:member_id])
    redirect_to :back
  end

end
