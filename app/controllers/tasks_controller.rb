class TasksController < ApplicationController
 before_action :find_task, only: [:show]

  def index
    @tasks = Task.all
  end

  def new
    # if params[:back]
    #   @task = Task.new(task_params)
    # else
    #   @task = Task.new
    # end
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if params[:back]
      render :new
    else
      if @task.save
        redirect_to @task, notice: "Posted"
      else
        render :new
      end
    end
  end

  def show

  end


  private
  def task_params
    params.require(:task).permit(:title, :content)
  end

  def find_task
    @task = Task.find(params[:id])
  end
end
