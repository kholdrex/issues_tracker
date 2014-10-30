namespace 'permissions' do
  desc "Loading all models and their related controller methods inpermissions table."
  task(:permissions => :environment) do
    arr = []
    #грузим все контроллеры
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry|
      if entry =~ /_controller/
        #Проверяем валидность контроллера
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*$/ #скопим имя контроллера
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |x|
          if x =~ /_controller/
            arr << "#{entry.titleize}::#{x.camelize.gsub('.rb', '')}".constantize
          end
        end
      end
    end

    arr.each do |controller|
      #только эти контроллеры воспроизводят модель
      if controller.permission
        write_permission(controller.permission, "manage", 'manage')
        controller.action_methods.each do |method|
          if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/
            name, cancan_action = eval_cancan_action(method)
            write_permission(controller.permission, cancan_action, name)
          end
        end
      end
    end
  end
end

#check if the permission is present else add a new one.
def write_permission(model, cancan_action, name)
  permission = Permission.find(:first, :conditions => ["subject_class = ? and action = ?", model, cancan_action])
  unless permission
    permission = Permission.new
    permission.name = name
    permission.subject_class = model
    permission.action = cancan_action
    permission.save
  end
end