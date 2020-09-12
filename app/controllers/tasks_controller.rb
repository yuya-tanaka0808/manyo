class TasksController < ApplicationController
 before_action :find_task, only: [:show, :edit, :update, :destroy]
 before_action :current_user
 before_action :login_required

  def index
    if params[:sort_expired]
      @tasks = current_user.tasks.all.order(time_limit: "DESC").page(params[:page]).per(10)
    elsif params[:sort_priority]
      @tasks = current_user.tasks.all.order(priority: "ASC").page(params[:page]).per(10)
    elsif params[:serch].present?
      if params[:serch][:title].present? && params[:serch][:status].present?
        @tasks = current_user.tasks.serch_title(params[:serch][:title]).serch_status(params[:serch][:status]).page(params[:page]).per(10)
      elsif params[:serch][:title].present?
        @tasks = current_user.tasks.serch_title(params[:serch][:title]).page(params[:page]).per(10)
      else params[:serch][:status].present?
        @tasks = current_user.tasks.serch_status(params[:serch][:status]).page(params[:page]).per(10)
      end
    else
      @tasks = current_user.tasks.all.order(id: "DESC").page(params[:page]).per(10)
    end
    #
    # if params[:task].present?
    #   @tasks = serch_title(params[:serch_title])
    # end
  end

  def new
    if params[:back]
      @task = Task.new(task_params)
    else
      @task = Task.new
    end
    # @task = Task.new
  end

  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to tasks_path, notice: t('notice.new')
      else
        render :new
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('notice.edit')
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: t('notice.delete')
  end

  def confirm
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :time_limit, :status, :priority, label_ids: [] )
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
