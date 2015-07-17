class SuperviseController < ApplicationController
  before_action :set_user, only: [:edit_user, :update_user, :destroy_user]

  def index
    @users = User.all.page params[:page]
    @groups = Group.all.page params[:page]
    @buddies = User.buddies current_user
    @errands = Errand.all.page params[:page]
    @overtimes = Overtime.all.page params[:page]
    @vacations = Vacation.all.page params[:page]
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
        format.html { redirect_to supervise_index_path(view: 'users'), notice: 'User was successfully created.' }
      else
        format.html { render :new_user }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_user
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to supervise_index_path(view: 'users'), notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy_user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to supervise_index_path(view: 'users'), notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def user_group_new

    @buddies = User.buddies current_user rescue []
  end

  def user_group_edit
    @supervisor = User.find(params[:id])
    @buddies = User.buddies current_user
  end

  def user_group_update
    ap @supervisor = User.find(params[:sp][:id])
    ap @supervisor.occupation = params[:sp][:occupation]
    ap @supervisor.save

    params[:sp][:buddies]
    .delete_if {|e| e == "" or e == "#{@supervisor.id}"}
    .map do |u|
      ap u = User.find(u.to_i)
      u.supervisor_id = @supervisor.id
      u.save
    end

    respond_to do |format|
      format.html { redirect_to supervise_index_path(view: 'groups'), notice: 'Leader was successfully selected.' }
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
      format.html { redirect_to supervise_index_path(view: "groups"), notice: 'Leader was successfully selected.' }
    end

  end

  def user_group_cancel
    @user = User.find(params[:id])
    @user.role = nil
    @user.occupation = nil
    @user.save

    (User.dfs @user).try :each do |u|
      u.role = nil
      u.occupation = nil
      u.supervisor_id = nil
      u.save
    end
    respond_to do |format|
      format.html { redirect_to supervise_index_path, notice: 'Leader was successfully unselected.' }
    end
  end

  def check_record_by_type
    obj = klassify(params[:cut],params[:id])
    respond_to do |format|
      if obj
        obj.approve = true
        obj.save
        format.html { redirect_to supervise_index_path(view: "#{params[:cut]}s"), notice: 'Record was successfully checked.' }
      else
        format.html { redirect_to supervise_index_path(view: "#{params[:cut]}s"), notice: 'Record was not successfully checked.' }
      end
    end
  end

  def issue_record_by_type
    obj = klassify(params[:cut],params[:id])
    respond_to do |format|
      if obj
        obj.issue = true
        obj.save
        format.html { redirect_to supervise_index_path(view: "#{params[:cut]}s"), notice: 'Record was successfully checked.' }
      else
        format.html { redirect_to supervise_index_path(view: "#{params[:cut]}s"), notice: 'Record was not successfully checked.' }
      end
    end
  end

  private

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

  def user_params
    params.require(:user).permit(
      :username,:user_number,:role,
      :nickname,:realname,:gender,:occupation,
    :join_at,:leave_at, :email,:supervisor_id)
  end

  def supervisor_params
    params.require(:supervisor).permit(:occupation,:supervisor_id,buddies: [])
  end

end
