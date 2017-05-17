module UserAccess
  
  private
  
  def require_admin
    flash[:danger] = "You must been an administrator to view this page"
    current_user.nil? ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
end