class SuperviseController < ApplicationController
  def index
    @users = User.all
  end

  # user operation without users_controller
  def new_user
    
  end

  def edit_user
    
  end

  def create_user
    
  end

  def update_user
    
  end

  def destroy_user
    
  end

  private
  def set_user
    
  end

  def user_params
    params.require(:project).permit(
      :username,:user_number
      :nickname,:realname,:gender,:occupation, 
      :join_at,:leave_at)
  end
  
end
