class TasksController < ApplicationController

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :description, :importance, :expiry
  validates_presence_of :name, :description
  validates_format_of :name, with: /[a-zA-Zа-яА-Я'][a-zA-Zа-яА-Я-' ]+[a-zA-Zа-яА-Я']?/u, :on => :create

  def index
    @tasks = current_user.tasks.all
    respond_to do |format|
      format.html{render 'tasks/index'}
      format.json{render :json => {tasks: @tasks}}
    end

    flash[:task_loc] = t(:task_loc)
    flash[:desk_loc] = t(:desk_loc)
    flash[:imp_loc] = t(:imp_loc)
    flash[:exp_loc] = t(:exp_loc)
    flash[:upd_loc] = t(:upd_loc)
    flash[:del_loc] = t(:del_loc)
    flash[:done_loc] = t(:done_loc)
    # render 'tasks/index'
  end

  def create
    current_user.tasks.create(task_create_params)
    redirect_to '/'
  end

  def edit
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to '/'
    end
  end

  def update
    task = current_user.tasks.find_by(id: params[:id])
    if task && params[:task]
      task.update!(task_update_params)
    end
    redirect_to '/'
  end

  def delete
    task = current_user.tasks.find_by(id: params[:id])
    if task
      task.destroy!
    end
    redirect_to '/'
  end

  def task_create_params
    params.require(:task).permit(:name, :description, :importance, :expiry)
  end

  def task_update_params
    params.require(:task).permit(:name, :description, :importance, :expiry, :is_done)
  end

end
