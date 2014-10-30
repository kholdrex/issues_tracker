#encoding: utf-8
module HelperMethods

  def get_errors(errors)
    result = []
    errors.each do |error|
      error[1].each{ |x| result << "<li>#{x}</li>" }
    end
    result.join('')
  end

  def is_active?(active)
    unless active[1].nil?
      'active' if active[0] == params[:controller] && active[1].include?(params[:action])
    else
      'active' if active[0] == params[:controller]
    end
  end

end