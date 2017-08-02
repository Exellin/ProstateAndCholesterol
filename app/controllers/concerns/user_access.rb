module UserAccess
  
  private
  
  def require_admin
    unless current_user.try(:admin)
      flash[:danger] = 'You must be an administrator to view this page'
      redirect_to root_path
    end
  end
  
  def require_same_user(object)
    if current_user != object.user
      flash[:danger] = 'You can only edit or delete your own content'
      redirect_to root_path
    end
  end
end