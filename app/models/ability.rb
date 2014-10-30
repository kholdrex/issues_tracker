class Ability
  include CanCan::Ability


  def initialize(user, project)

    alias_action :index, :show, :to => :read
    alias_action :new, :to => :create
    alias_action :edit, :to => :update
    
    permissions = user.permissions_for_project(project) || []
    permissions.each do |permission|
      if permission.subject_class == "all"
        can permission.action.to_sym, permission.subject_class.to_sym
      else
        can permission.action.to_sym, permission.subject_class.constantize
      end
    end
  end

end
