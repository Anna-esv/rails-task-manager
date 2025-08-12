# Controller for managing Task resources.
# Provides actions to list, show, create, update, and delete tasks.
# Uses before_action to set the task for relevant actions.
# Handles strong parameters for task creation and updates.
#
# Actions:
# - index: Lists all tasks.
# - show: Displays a single task.
# - new: Renders form for a new task.
# - create: Creates a new task.
# - edit: Renders form to edit a task.
# - update: Updates an existing task.
# - destroy: Deletes a task.
#
# Private methods:
# - set_task: Finds and sets the task based on params[:id].
# - task_params: Permits only allowed parameters for tasks.
class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show; end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to tasks_path, status: :see_other, notice: 'Tâche supprimée'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end
end
