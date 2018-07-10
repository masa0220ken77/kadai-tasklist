class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :login_check, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success] = 'Task が正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Taskが追加されませんでした'
      render :new
    end
  end

  def edit
  end

  def update

    if @task.update(task_params)
      flash[:success] = 'Task は追加に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は追加されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end

  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
  end

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :userid)
  end  
  
  def login_check
    if @task.nil?
      redirect_to root_path
    end
  end
end