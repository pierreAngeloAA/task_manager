class Api::TasksController < ApplicationController
  include Authenticable

  before_action :find_task, only: [:show, :update, :destroy]

  def index
    render json: @current_user.tasks
  end

  def show
    render json: @task
  end

  def create
    task = @current_user.tasks.new(task_params)
    if task.save
      render json: task
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: { errors: @task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    render json: @current_user.tasks
  end

  private

  def find_task
    @task = @current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :due_date)
  end
end
