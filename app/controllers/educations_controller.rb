class EducationsController < ApplicationController
  def index
    @educations = Profile.educations(current_user.id)
  end

  def create
    @education = Education.new(params[:education])
    @education.graduation_date = params[:education][:graduation_date].to_i
    @education.user_id = current_user.id
    if @education.save
      flash[:notice] = "Education saved sucessfuly"
    else
      error_messages(@education)
    end
    redirect_to educations_path
  end

  def destroy
    @education = Education.find(params[:id])
    @education.destroy
    @educations = Profile.educations(current_user.id)
    #flash[:notice] = "Education deleted sucessfuly"
    
    respond_to do |format|
      format.html
      format.js
    end
  end

  def side_bar
    @users_with_same_school = Profile.users_with_same_school
    @users_with_same_course = Profile.users_with_same_course
    @users_with_same_graduation_date = Profile.users_with_same_graduation_date
  end
end
