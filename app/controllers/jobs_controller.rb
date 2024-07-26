# app/controllers/jobs_controller.rb
class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update, :destroy]

  def index
    @jobs = Job.all
  end

  def show
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.salesman = current_user

    if @job.save
      redirect_to job_path(@job), notice: 'Job was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job.update(job_params)
      redirect_to @job, notice: 'Job was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @job.present? && @job.salesman == current_user
      @job.destroy
      redirect_to root_path, notice: 'Job was successfully deleted.'
    else
      redirect_to root_path, alert: 'Job not found or not authorized to delete.'
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:job_number, :customer_name, :address, :customer_phone, :customer_email, :total_amount, :type_of_work, :salesman_id, :city, :state, :country)
  end

  def authorize_user!
    redirect_to root_path, alert: 'Not authorized' unless @job.salesman == current_user
  end
end
