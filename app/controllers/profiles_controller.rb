class ProfilesController < ApplicationController
  # GET /profiles
  # GET /profiles.json
  def index
    @profile = Profile.find_by_user_id(current_user.id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @profile }
    end
  end

  def edit
    @profile = Profile.find_by_user_id(current_user.id)
    @users_from_same_location = @profile.users_from_same_location    
  end

  # PUT /profiles/1
  # PUT /profiles/1.json
  def update
    @profile = Profile.find_by_user_id(current_user.id)

    if @profile.update_attributes(params[:profile])
    flash[:notice] = "Personal info saved sucessfuly"
    else
      error_messages(@profile)
    end

    redirect_to edit_profile_path
  end
end
