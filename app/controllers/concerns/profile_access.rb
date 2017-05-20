module ProfileAccess
  
  private
  
  def require_filled_profile
    if current_user == @profile.user && @profile.empty?
      flash[:danger] = "You have to create your profile before you can view this page"
      redirect_to edit_profile_path(@profile)
    end
  end
end