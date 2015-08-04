class SuperviseController < ApplicationController
  before_action :set_user, only: [:edit_user, :update_user, :destroy_user]
  before_action :set_buddies, only: [:users,:groups, :overtimes,:errands,:vacations,:projects]
  def index

  end

  def users
    @users = User.all
  end

  def groups
    @groups = Group.all.page params[:page]
  end

  def overtimes
    @overtimes = Overtime.all
  end

  def errands
    @errands = Errand.all
  end

  def vacations
    @vacations = Vacation.all
  end

  def projects
    @projects = Project.all.page params[:page]
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
    @user.email = "#{user_params[:username]}@eurus.cn"
    @user.username = user_params[:username]
    @user.password = '12345678'
    default_user_avatar @user
    respond_to do |format|
      if @user.save
        format.html { redirect_to supervise_users_path, notice: 'User was successfully created.' }
      else
        format.html { render :new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to supervise_users_path, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to supervise_users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_group_new
    @buddies = User.buddies current_user rescue []
  end

  def user_group_edit
    @supervisor = User.find(params[:id])
    @buddies = User.buddies @supervisor
  end

  def user_group_update
    @supervisor = User.find(params[:sp][:id])
    @supervisor.occupation = params[:sp][:occupation]
    @supervisor.save

    remain_buddies = params[:sp][:buddies].delete_if{|e|e==""}.map { |e| e.to_i }
    current_buddies =  (User.buddies @supervisor).map { |e| e.id }
    ap opt_buddies = current_buddies - remain_buddies

    opt_buddies
    .map { |e| User.find e }
    .map { |e|
      User.dfs e
    }.flatten.map do |e|
      e.role = 'staff' unless e.role == 'intern'
      e.occupation = nil
      e.supervisor_id = nil
      e.save
    end

    respond_to do |format|
      format.html { redirect_to supervise_groups_path, notice: 'Leader was successfully selected.' }
    end
  end

  def user_group_create
    # find this supervisor and set its supervisor_id
    # to current_user.id

    @supervisor = User.find(supervisor_params[:supervisor_id])
    @supervisor.supervisor_id = current_user.id
    @supervisor.role = User::USERROLE[User::USERROLE.index(current_user.role) + 1]
    @supervisor.occupation = supervisor_params[:occupation]
    @supervisor.save
    # find each buddy and set thier supervisor id to
    # params supervisor_id
    supervisor_params[:buddies]
    .delete_if {|e| e == "" or e == "#{supervisor_params[:supervisor_id]}"}
    .map do |u|
      u = User.find(u.to_i)
      u.supervisor_id = supervisor_params[:supervisor_id]
      ap u.save
    end
    respond_to do |format|
      format.html { redirect_to supervise_groups_path, notice: 'Leader was successfully selected.' }
    end

  end

  def user_group_cancel
    @user = User.find(params[:id])
    @user.role = 'staff' unless @user.role == 'intern'
    @user.occupation = nil
    @user.save

    ((User.dfs @user).try :flatten).try :each do |u|
      e.role = 'staff' unless e.role == 'intern'
      u.occupation = nil
      u.supervisor_id = nil
      u.save
    end
    respond_to do |format|
      format.html { redirect_to supervise_groups_path, notice: 'Leader was successfully unselected.' }
    end
  end

  def check_record_by_type
    obj = klassify(params[:cut],params[:id])
    respond_to do |format|
      if obj
        obj.approve = true
        obj.save
        case params[:cut]
        when "overtime"
          format.html { redirect_to supervise_overtimes_path, notice: 'Record was successfully checked.' }
        when "errand"
          format.html { redirect_to supervise_errands_path, notice: 'Record was successfully checked.' }
        else
          format.html { redirect_to supervise_vacations_path, notice: 'Record was successfully checked.' }
        end
      else
        case params[:cut]
        when "overtime"
          format.html { redirect_to supervise_overtimes_path, notice: 'Record was not successfully checked.' }
        when "errand"
          format.html { redirect_to supervise_errands_path, notice: 'Record was not successfully checked.' }
        else
          format.html { redirect_to supervise_vacations_path, notice: 'Record was not successfully checked.' }
        end
      end
    end
  end

  def issue_record_by_type
    obj = klassify(params[:cut],params[:id])
    respond_to do |format|
      if obj
        obj.issue = true
        obj.approve = true
        obj.save
        case params[:cut]
        when "overtime"
          format.html { redirect_to supervise_overtimes_path, notice: 'Record was successfully checked.' }
        when "errand"
          format.html { redirect_to supervise_errands_path, notice: 'Record was successfully checked.' }
        else
          format.html { redirect_to supervise_vacations_path, notice: 'Record was successfully checked.' }
        end
      else
        case params[:cut]
        when "overtime"
          format.html { redirect_to supervise_overtimes_path, notice: 'Record was not successfully checked.' }
        when "errand"
          format.html { redirect_to supervise_errands_path, notice: 'Record was not successfully checked.' }
        else
          format.html { redirect_to supervise_vacations_path, notice: 'Record was not successfully checked.' }
        end
      end
    end
  end

  private

  def default_user_avatar(u)
    image_arr = ["user1.jpg","user2.jpg","user3.jpg","user4.jpg","user5.jpg"]
    File.open(Rails.root.join("app/assets/images/user/#{image_arr[rand image_arr.length]}")) do |f|
      u.avatar = f
    end
    return u
  end

  def klassify(str, id)
    if ["errand","overtime","vacation"].include? str
      klass = str[0].capitalize+str[1..-1]
      return klass.constantize.find(id)
    else
      return nil
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_buddies
    @buddies = User.buddies current_user
  end
  def user_params
    params.require(:user).permit(
      :username,:user_number,:role,:birthday,
      :nickname,:realname,:gender,:occupation,
    :join_at,:leave_at, :email,:supervisor_id)
  end

  def supervisor_params
    params.require(:supervisor).permit(:occupation,:supervisor_id,buddies: [])
  end

end
