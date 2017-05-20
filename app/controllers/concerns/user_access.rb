module UserAccess
  
  private
  
  def require_admin
    flash[:danger] = "You must be an administrator to view this page"
    current_user.nil? ? redirect_to(root_path) : (redirect_to(root_path) unless current_user.admin?)
  end
  
  def require_same_user(object)
    if current_user != object.user and !current_user.admin?
      flash[:danger] = "You can only edit or delete your own content"
      redirect_to root_path
    end
  end
end