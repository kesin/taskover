class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan_list, only: [:new, :create, :update, :update_sort]
  before_action :set_task, only: [:update, :destroy]

  # GET /tasks/new
  def new
    @task = @list.tasks.new
  end

  # POST /tasks.json
  def create
    @task = @plan.tasks.new(task_params)
    @task.list = @list
    @task.user_id = current_user.id

    unless @task.save
      render json: {status: 'failed', message: '创建失败，请稍后重试 !'}
    end
  end

  # PATCH/PUT /tasks/1.json
  def update
    unless @task.update(task_params)
      render json: {status: 'failed', message: '任务更新失败, 请稍后重试 !'}
    end
  end

  # PATCH/PUT /tasks/update_sort.json
  def update_sort
    list_sort = @list.task_sort
    list_sort = @list.build_task_sort if list_sort.nil?
    list_sort.sort = params[:sort].split(',').map(&:to_i)
    unless list_sort.save
      render json: {status: 'failed', message: '更新失败，请稍后重试 !'}
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: '任务已被删除!' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan_list
      @plan = current_user.plans.find_by_ident(params[:plan_id])
      @list = current_user.lists.find_by_id(params[:list_id])
      unless @plan && @list
        respond_to do |format|
          format.html { redirect_to root_url, alert: '此计划或列表不存在' }
          format.json { render json: {alert: '此计划或列表不存在'} }
        end
      end
    end

    def set_task
      @task = current_user.tasks.find(params[:id])
      unless @task
        respond_to do |format|
          format.html { redirect_to root_url, alert: '此任务不存在' }
          format.json { render json: {alert: '此任务不存在'} }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :status)
    end
end
