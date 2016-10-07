class ListsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_plan, only: [:new, :create]
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
    respond_to do |format|
      if @list.update(list_params)
        format.html { redirect_to @list, notice: '列表已经成功更新!' }
        format.json { render :show, status: :ok, location: @list }
      else
        format.html { render :edit }
        format.json { render json: @list.errors, status: :unprocessable_entity }
      end
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
