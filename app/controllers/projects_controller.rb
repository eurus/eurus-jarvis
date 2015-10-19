class ProjectsController < ApplicationController
  before_action :set_project, only: [:done]

  # GET /projects
  # GET /projects.json
  def index
    @projects = (Project.includes(:users).includes(:owner).where(owner: current_user.id) + current_user.projects).uniq
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

  # def show

  # end
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

end
