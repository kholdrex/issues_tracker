#encoding: utf-8
module IssuesHelper
  include ActionView::Helpers::UrlHelper

  def before_new_issue
    @statuses = IssueStatus.all
    @priorities = IssuePriority.all
    puts 1111111111111
    puts Project.last
    @issues = @project.issues
    @issue = Issue.new()
    @trackers = @project.trackers
    @users = @project.members.collect {|x| [x.user.email, x.user.id]}
    flash[:error] = "К проекту не привязан ни один трекер. Пожалуйста добавьте трекеры к проекту, перейдя в меню #{link_to('Настройки', project_settings_path(@project))}".html_safe if @trackers.empty?
  end
end
