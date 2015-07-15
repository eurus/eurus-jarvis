class SuperviseController < ApplicationController
  before_action :set_user, only: [:edit_user, :update_user, :destroy_user]
  before_action :set_group, only: [:edit_group, :update_group, :destroy_group]
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

  # group
  def new_group
    @group = Group.new
    case current_user.occupation
    when "ceo"
      ids = User.ceo.map { |e| e.id }
      @collection = User.all_except(ids).collect {|p| [ "#{p.email}:#{p.nickname}",p.id ]}
    when "director"
      ids = User.ceo.or.director.map { |e| e.id }
      @collection = User.all_except(ids).collect {|p| [ "#{p.email}:#{p.nickname}",p.id ]}
    when "pm"
      ids = User.ceo.or.director.or.pm.map { |e| e.id }
      @collection = User.all_except(ids).collect {|p| [ "#{p.email}:#{p.nickname}",p.id ]}
    else
      @collection = []
    end
  end

  def edit_group

  end

  def create_group
    @group = Group.new(group_params)
    @user = User.find(@group.leader)
    @user.occupation = User::USERROLE[User::USERROLE.index(current_user.occupation) + 1]
    respond_to do |format|
      if @group.save && @user.save
        format.html { redirect_to supervise_index_path, notice: 'Group was successfully created.' }
      else
        format.html { render :new_group }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_group
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to supervise_index_path, notice: 'Group was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_group
    @group.destroy
    respond_to do |format|
      format.html { redirect_to supervise_index_path, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def set_group
    @group = Group.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username,:user_number,
      :nickname,:realname,:gender,:occupation,
    :join_at,:leave_at, :email)
  end

  def group_params
    params.require(:group).permit(:name, :leader,:ids)
  end

end
