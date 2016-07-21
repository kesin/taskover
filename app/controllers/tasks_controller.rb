class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: [:update, :action, :destroy]

  # GET /tasks/new
  def new
    @list = current_user.lists.find_by_id(params[:list_id])
    return redirect_to root_path, alert: '不存在此列表' unless @list
    @plan = @list.plan
    @task = @list.tasks.new
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @plan = current_user.plans.find_by_ident(params[:plan_id])
    return redirect_to root_path, alert: '不存在此计划' unless @plan
    @task = @plan.tasks.new(task_params)
    @task.list_id = params[:list_id]
    @task.user_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to @plan, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def action
    case params[:type]
      when 'close'
        @task.close!
      when 'open'
        @task.open!
      else
        return redirect_to :back, notice: 'Update status failed.'
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Task was successfully updated.' }
      format.json { render :show, status: :ok, location: @task }
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = current_user.tasks.find(params[:id])
      return redirect_to root_path, alert: '不存在此任务' unless @task
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:title, :description, :status)
    end
end
