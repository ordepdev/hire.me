class SkillsController < ApplicationController
  def index
    @skills = Skill.find_all_by_user_id(current_user.id)
  end

  def create
    message = ''
    skills = params[:skill][:name].split(',')
    if skills.empty?
      flash[:error] = "* Skill can't be blank" 
    else
      skills.each do |skill|
        @new_skill = Skill.new
        @new_skill.user_id =  current_user.id 
        @new_skill.name = skill
        if @new_skill.save
          flash[:notice] = "Skills saved sucessfuly"
        else
          error_messages(@new_skill)
        end
      end
    end
    redirect_to skills_path
  end

  def destroy
    @skill = Skill.find(params[:id])
    @skill.destroy
    @skills = Skill.find_all_by_user_id(current_user.id)
    flash[:notice] = "Skills deleted sucessfuly"

    respond_to do |format|
      format.html
      format.js
    end
  end
end
