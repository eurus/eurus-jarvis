class SuperviseController < ApplicationController
  before_action :set_user, only: [:edit_user, :update_user, :destroy_user]

  def index
    @users = User.all
  end

  # user operation without users_controller
  def new_user
    @user = User.new
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
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:project).permit(
      :username,:user_number,
      :nickname,:realname,:gender,:occupation, 
      :join_at,:leave_at)
  end
  
end
