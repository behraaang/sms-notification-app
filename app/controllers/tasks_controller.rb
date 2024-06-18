# app/controllers/tasks_controller.rb
class TasksController < ApplicationController
    skip_before_action :verify_authenticity_token
    
    def index
      @tasks = Task.all
      render json: @tasks
    end
  
    def create
      @task = Task.new(task_params)
      if @task.save
        render json: @task, status: :created
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
    def update
      @task = Task.find(params[:id])
      if @task.update(task_params)
        render json: @task
      else
        render json: @task.errors, status: :unprocessable_entity
      end
    end
  
    private
  
    def task_params
      params.require(:task).permit(:title, :status)
    end
  end
  