class TasksController < ApplicationController
 before_action :find_task, only: [:show, :edit, :update, :destroy]

  def index
    if params[:sort_expired]
      @tasks = Task.all.order(time_limit: "DESC")
    elsif params[:serch].present?
      if params[:serch][:title].present? && params[:serch][:status].present?
        @tasks = Task.serch_title(params[:serch][:title]).serch_status(params[:serch][:status])
      elsif params[:serch][:title].present?
        @tasks = Task.serch_title(params[:serch][:title])
      else params[:serch][:status].present?
        @tasks = Task.serch_status(params[:serch][:status])
      end
    else
      @tasks = Task.all.order(id: "DESC")
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
    @task = Task.new(task_params)
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
    @task = Task.new(task_params)
    render :new if @task.invalid?
  end

  private
  def task_params
    params.require(:task).permit(:title, :content, :time_limit, :status, :priority)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
