class PlansController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:show, :update, :destroy, :update_task_sort]

  # GET /p.json
  def index
    if json_request?
      sort = current_user.plan_sort.nil? ? current_user.plans.pluck(:id) : current_user.plan_sort.sort
      @plans = current_user.plans.sort_by{|e| sort.index(e.id)}
    end
  end

  # GET /p/ScAJJIBl.json
  def show
    gon.plan_ident = params[:id]
    if json_request?
      sort = @plan.list_sort.nil? ? @plan.lists.pluck(:id) : @plan.list_sort.sort
      @lists = @plan.lists.includes(:tasks, :task_sort).sort_by{|e| sort.index(e.id)}
    end
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

  # PATCH/PUT /p/update_sort.json
  def update_sort
    plan_sort = current_user.plan_sort
    plan_sort = current_user.build_plan_sort if plan_sort.nil?
    plan_sort.sort = params[:sort].split(',').map(&:to_i)
    unless plan_sort.save
      render json: {status: 'failed', message: '更新失败，请稍后重试 !'}
    end
  end

  # PATCH/PUT /p/xxxx/update_sort.json
  def update_task_sort
    to_list = @plan.lists.find(params['to_list_id'])
    to_list_sort = to_list.task_sort
    to_list_sort = to_list.build_task_sort if to_list_sort.nil?
    to_list_sort.sort = params[:to_sort].split(',').map(&:to_i)
    if params['from_list_id'].present?
      task = @plan.tasks.find(params['task_id'])
      task.update_column(:list_id, params['to_list_id'])
      from_list = @plan.lists.find(params['from_list_id'])
      from_list_sort = from_list.task_sort
      from_list_sort = from_list.build_task_sort if from_list_sort.nil?
      from_list_sort.sort = params[:from_sort].split(',').map(&:to_i)
    end
    unless to_list_sort.save && (from_list_sort.present? && from_list_sort.save)
      render json: {status: 'failed', message: '更新失败，请稍后重试 !'}
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    unless @plan.update(plan_params)
      render json: {status: 'failed', message: '更新失败，请稍后重试 !'}
    end
  end


  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    render json: {status: 'success', message: '删除成功，正在返回首页...'}
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
