# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def admin?
    if session[:admin] == true then
      return true
    else
      return false
    end
  end

end
