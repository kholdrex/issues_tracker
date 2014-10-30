#encoding: utf-8
module ProjectsHelper

  def project_title(project)
    @proj = project
    result = []
    while @proj != nil
      if @proj != project
        result << link_to(@proj.name, project_path(@proj))
      else
        result << @proj.name
      end
      @proj = @proj.parent
    end
    result.reverse.join(' » ').html_safe
  end

end
