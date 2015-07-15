class SuperviseController < ApplicationController
  before_action :set_user, only: [:edit_user, :update_user, :destroy_user]
  
  def index
    @users = User.all.page params[:page]
    @groups = Group.all.page params[:page]
  end

  # user operation without users_controller
  def new_user
    @user = User.new
  end

  def edit_user

  end

  def create_user
    @user = User.new(user_params)
    # set default password to 12345678
    @user.password = '12345678'
    respond_to do |format|
      if @user.save
        format.html { redirect_to supervise_index_path, notice: 'User was successfully created.' }
      else
        format.html { render :new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to supervise_index_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to supervise_index_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_group_new
    case current_user.role
    when "ceo"
      @buddies = []
    when "director"
      @buddies = []
    when "pm"
      @buddies = []
    else 
      @buddies = []
    end
  end

  def user_group_edit
    
  end

  def user_group_create
    
  end

  def user_group_destroy
    
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,:user_number,:role,
      :nickname,:realname,:gender,:occupation,
    :join_at,:leave_at, :email,:supervisor_id)
  end

  def supervisor_params
    params.require(:supervisor).permit(:occupation,:supervisor_id)
  end

end
