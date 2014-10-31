module DefaultRole
  def default_permissions
    Permission.new(subject_class: 'all', action: 'read')
  end
end