class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # app/controllers/tasks_controller.rb
def index
  if params[:q]&.key?(:status_eq)
    params[:q][:status_eq] = Task.status_value(params[:q][:status_eq])
  end

  if params[:q]&.key?(:deadline_lteq) && params[:q][:deadline_lteq].present?
    params[:q][:deadline_lteq] = params[:q][:deadline_lteq].to_date + 1.day
  end

  @q = Task.ransack(params[:q])
  @tasks = @q.result(distinct: true)
end


  # GET /tasks/1
  def show
  end

  # GET /tasks/new
  def new
    @task = Task.new
  end

  # GET /tasks/1/edit
  def edit
  end

  # POST /tasks
  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to @task, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      redirect_to @task, notice: 'Task was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:title, :description, :status, :deadline)
    end
end
