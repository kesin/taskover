class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:new, :create, :update_sort, :update]
  before_action :set_list, only: [:update, :destroy]

  # GET /lists/new
  def new
    @list = @plan.lists.new
  end

  # POST /lists.json
  def create
    @list = @plan.lists.new(list_params)
    @list.user_id = current_user.id

    unless @list.save
      render json: {status: 'failed', message: '创建失败，请稍后重试 !'}
    end
  end

  # PATCH/PUT /lists/1
  # PATCH/PUT /lists/1.json
  def update
    unless @list.update(list_params)
      render json: {status: 'failed', message: '更新失败，请稍后重试 !'}
    end
  end

  # PATCH/PUT /p/update_sort.json
  def update_sort
    list_sort = @plan.list_sort
    list_sort = @plan.build_list_sort if list_sort.nil?
    list_sort.sort = params[:sort].split(',').map(&:to_i)
    unless list_sort.save
      render json: {status: 'failed', message: '更新失败，请稍后重试 !'}
    end
  end

  # DELETE /lists/1.json
  def destroy
    @list.destroy
    render json: {status: 'success', message: '删除列表成功!'}
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = current_user.plans.find_by_ident(params[:plan_id])
      unless @plan
        respond_to do |format|
          format.html { redirect_to root_url, alert: '此计划不存在' }
          format.json { render json: {alert: '此计划不存在'} }
        end
      end
    end

    def set_list
      @list = current_user.lists.find(params[:id])
      unless @list
        respond_to do |format|
          format.html { redirect_to root_url, alert: '此列表不存在' }
          format.json { render json: {alert: '此列表不存在'} }
        end
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def list_params
      params.require(:list).permit(:title, :color_tag)
    end
end
