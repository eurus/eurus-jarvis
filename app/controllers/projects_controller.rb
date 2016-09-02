class ProjectsController < ApplicationController
  before_action :set_project, only: [:done, :show, :webhook]
  skip_before_action :verify_authenticity_token, only: [:webhook]
  skip_before_action :authenticate_user!, :only => [:webhook]

  # GET /projects
  # GET /projects.json
  def index
    @projects = (Project.includes(:users).includes(:owner).includes(:errands).where(owner: current_user.id) + current_user.projects.includes(:owner).includes(:users).includes(:errands)).uniq
  end

  # # GET /projects/new
  # def new
  #   @project = Project.new
  #   set_local
  # end

  # # GET /projects/1/edit
  # def edit
  #   set_local
  # end
  #

  def webhook
    content = "<h4>#{params[:verb]}  #{params[:url]}</h4><p>Params: #{params[:params]}</p><p>Session Attribute: #{params[:session]}</p><p>Exception: #{params[:exception]}</p>"
    @project_logs = ProjectLog.create(project: @project, category: 'ERROR', content: content, date: Date.today)
    render json: 'success'
  end

  def show
    @project_logs = @project.project_logs.includes(:user)
    @project_log = ProjectLog.new
  end

  def create_log
    @project_log = ProjectLog.new(project_log_params)
    @project_log.project = @project
    @project_log.user = current_user
    @project_log.save
    redirect_to action: :show
  end
  # # POST /projects
  # # POST /projects.json
  # def create
  #   @project = Project.new(project_params)

  #   respond_to do |format|
  #     if @project.save
  #       format.html { redirect_to projects_url, notice: 'Project was successfully created.' }
  #     else
  #       format.html { render :new,locals: {col: set_local } }
  #       format.json { render json: @project.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /projects/1
  # # PATCH/PUT /projects/1.json
  # def update
  #   respond_to do |format|
  #     if @project.update(project_params)
  #       format.html { redirect_to projects_url, notice: 'Project was successfully updated.' }
  #     else
  #       format.html { render :edit , locals: {col: set_local }}
  #       format.json { render json: @project.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /projects/1
  # # DELETE /projects/1.json
  # def destroy
  #   @project.destroy
  #   respond_to do |format|
  #     format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  # def join
  #   # find the current project
  #   project = Project.find(params[:puser][:pid])
  #   # get users ids from params
  #   users = params[:puser][:buddies]
  #   .delete_if {|e| e == "" }
  #   .map { |e| e.to_i }
  #   # remove all user from prject.users
  #   # then add the users selected again
  #   project.users.delete_all
  #   project.users << User.find(users)

  #   respond_to do |format|
  #     format.html { redirect_to projects_url, notice: 'My little good buddy was successfully added.' }
  #   end
  # end

  # def done
  #   @project.status = 'done'
  #   @project.done_at = Date.current
  #   @project.save


  #   respond_to do |format|
  #     format.html { redirect_to projects_url, notice: 'Project successfully finished!' }
  #   end

  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  def project_log_params
    params.require(:project_log).permit(:category, :date, :project_id, :content)
  end
end
