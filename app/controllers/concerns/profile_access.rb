module ProfileAccess
  
  private
  
  def require_filled_profile
    if @profile.empty?
      flash[:danger] = "You have to create your profile before you can view this page"
      redirect_to edit_profile_path(@profile)
    end
  end
end