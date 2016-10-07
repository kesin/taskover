class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:show, :update, :destroy]

  # GET /p.json
  def index
    @plans = current_user.plans if json_request?
  end

  # GET /p/ScAJJIBl.json
  def show
    gon.plan_ident = params[:id]
    @lists = @plan.lists.includes(:tasks) if json_request?
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # TODO catch uniqueness exception and redo
  # POST /p.json
  def create
    @plan = Plan.new(plan_params)
    @plan.add_ident
    @plan.user_id = current_user.id
    unless @plan.save
      render json: {status: 'failed', message: '创建失败，请稍后重试 !'}
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to root_url, notice: '计划项已经更新 !' }
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
      format.html { redirect_to root_url, notice: '计划项删除成功 !' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      return unless json_request?
      @plan = current_user.plans.find_by_ident(params[:id])
      return render json: { status: 'failed', alert: '此计划不存在' } unless @plan
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:title, :description, :color_tag)
    end
end
