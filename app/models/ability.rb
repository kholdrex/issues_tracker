class Ability
  include CanCan::Ability
  include DefaultRole

  def initialize(user, project)

    alias_action :index, :show, :to => :read
    alias_action :new, :create, :to => :action_create
    alias_action :edit, :to => :update
    alias_action :delete, :to => :destroy
    alias_action :info, :members, :modules, :activities, :add_members, :remove_member, to: :settings

    permissions = user.permissions_for_project(project) || []
    permissions << default_permissions

    permissions.each do |permission|
      if permission.subject_class == "all"
        can permission.action.to_sym, permission.subject_class.to_sym
      else
        can permission.action.to_sym, permission.subject_class.constantize
      end
    end

    can [:read, :action_create, :update, :settings], :all if user.is_admin?
  end

end
