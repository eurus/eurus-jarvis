class ErrandsController < ApplicationController
  before_action :set_errand, only: [:show, :edit, :update, :destroy]

  # GET /errands
  # GET /errands.json
  def index
    if current_user.role == 'ceo'
      @errands = Errand.all.order(:created_at :desc).page params[:page]
    else

    end
    @errands = current_user.errands.page params[:page]
  end

  # GET /errands/new
  def new
    @errand = Errand.new
  end

  # GET /errands/1/edit
  def edit
  end

  # POST /errands
  # POST /errands.json
  def create
    @errand = Errand.new(errand_params)
    @errand.user_id = current_user.id
    respond_to do |format|
      if @errand.save
        format.html { redirect_to errands_url, notice: 'Errand was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @errand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /errands/1
  # PATCH/PUT /errands/1.json
  def update
    respond_to do |format|
      if @errand.update(errand_params)
        format.html { redirect_to errands_url, notice: 'Errand was successfully updated.' }
      else
        format.html { render :edit }
        format.json { render json: @errand.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /errands/1
  # DELETE /errands/1.json
  def destroy
    @errand.destroy
    respond_to do |format|
      format.html { redirect_to errands_url, notice: 'Errand was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_errand
    @errand = Errand.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def errand_params
    params.require(:errand).permit(:location, :content, :start_at, :end_at, :project_id, :user_id, :fee, :check, :issue)
  end
end
