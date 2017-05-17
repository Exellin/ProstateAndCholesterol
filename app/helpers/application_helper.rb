module ApplicationHelper
  
  def flash_class_name(name)
    case name
      when 'notice' then 'success'
      when 'alert'  then 'danger'
      else name
    end
  end
  
  def require_admin
    flash[:danger] = "You must been an administrator to view this page"
    current_user.nil? ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
end
