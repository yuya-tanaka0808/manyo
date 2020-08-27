class TasksController < ApplicationController

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
        redirect_to tasks_path,notice: "Posted"
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
end
