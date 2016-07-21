class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:show, :update, :destroy]

  # GET /plans
  # GET /plans.json
  def index
    @plans = current_user.plans
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
    # TODO sort task by status
    @lists = @plan.lists.includes(:tasks)
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # TODO catch uniqueness exception and redo
  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    @plan.add_ident
    @plan.user_id = current_user.id

    respond_to do |format|
      if @plan.save
        format.html { redirect_to root_url, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to root_url, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to root_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = current_user.plans.find_by_ident(params[:id])
      return redirect_to root_path, alert: '不存在此计划' unless @plan
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:title, :description, :color_tag)
    end
end
