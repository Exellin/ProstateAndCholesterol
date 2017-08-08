class ProfilesController < ApplicationController
  include UserAccess
  include ProfileAccess
  before_action :set_profile, only: [:edit, :show, :update]
  before_action :authenticate_user!, except: [:show]
  before_action only: [:edit, :update] { require_same_user(@profile) }
  before_action :require_filled_profile, only: [:show]

  def edit; end

  def show
    @psa_histories = @profile.psa_histories.select(:psa, :month, :year).as_json(except: :id)
    @total_cholesterol_histories = @profile.cholesterol_histories.select(:total_cholesterol, :month, :year)
                                           .as_json(except: :id)
    @hdl_histories = @profile.cholesterol_histories.select(:hdl, :month, :year).as_json(except: :id)
    @ldl_histories = @profile.cholesterol_histories.select(:ldl, :month, :year).as_json(except: :id)
    @triglyceride_histories = @profile.cholesterol_histories.select(:triglyceride, :month, :year)
                                      .as_json(except: :id)
    @glucose_histories = @profile.cholesterol_histories.select(:glucose, :month, :year).as_json(except: :id)
  end

  def update
    if params[:profile][:psa_histories_attributes]
      message = 'Your PSA History has been successfully updated'
      render_path = 'psa_histories/index'
    elsif params[:profile][:cholesterol_histories_attributes]
      message = 'Your Cholesterol History has been successfully updated'
      render_path = 'cholesterol_histories/index'
    elsif params[:profile][:medications_attributes]
      message = 'Your Medications have been successfully updated'
      render_path = 'medications/index'
    elsif @profile.empty?
      message = 'Your profile has been successfully created'
      render_path = 'edit'
    else
      message = 'Your profile has been successfully updated'
      render_path = 'edit'
    end
    if @profile.update(profile_params)
      flash[:success] = message
      redirect_to profile_path(@profile)
    else
      render render_path
    end
  end

  private

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.require(:profile).permit(
      :first_name, :last_name, :birth_year, :city, :administrative_division, :country,
      :years_in_current_locale, :ancestral_descent, :race, :ethnicity, :age_noticed_symptoms,
      :age_urinary_malfunction, :age_bladder_infection, :story,
      psa_histories_attributes: [:id, :psa, :month, :year, :_destroy],
      cholesterol_histories_attributes: [:id, :total_cholesterol, :hdl, :ldl, :triglyceride,
                                         :glucose, :month, :year, :_destroy],
      medications_attributes: [:id, :purpose, :age_recommended, :age_prescribed, :name, :strength,
                               :dosage, :month_last_used, :year_last_used, :still_using, :_destroy]
    )
  end
end
