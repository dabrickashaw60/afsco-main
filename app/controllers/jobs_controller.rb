class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  before_action :authorize_super_admin, only: [:assign_job, :unassign_job]

  def index
    @jobs = Job.all

    if params[:search].present?
      @jobs = @jobs.joins(:salesman).where(
        "job_number ILIKE :search OR customer_name ILIKE :search OR users.name ILIKE :search OR address ILIKE :search OR city ILIKE :search OR state ILIKE :search OR country ILIKE :search OR type_of_work ILIKE :search", 
        search: "%#{params[:search]}%"
      )
    end

    if params[:sort] == 'salesman'
      @jobs = @jobs.joins(:salesman)
    end

    @jobs = @jobs.order(sort_column + ' ' + sort_direction)

    respond_to do |format|
      format.html
      format.js # This will render index.js.erb
    end
  end
  def show
  end

  def new
    @job = Job.new
    @salesmen = User.where(role: 'salesman')
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      redirect_to @job, notice: 'Job was successfully created.'
    else
      puts @job.errors.full_messages # Add this line to print errors to the server log
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @salesmen = User.where(role: 'salesman')
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
      redirect_to jobs_path, notice: 'Job was successfully deleted.'
    else
      redirect_to jobs_path, alert: 'Job not found or not authorized to delete.'
    end
  end

  def assign_job
    job = Job.find(params[:job_id])
    start_date = Date.parse(params[:start_date])
    end_date = Date.parse(params[:end_date])
    crew_id = params[:crew_id].to_i

    Assignment.where(job_id: job.id, crew_id: crew_id, date: start_date..end_date).destroy_all

    (start_date..end_date).each do |date|
      Assignment.create!(job_id: job.id, crew_id: crew_id, date: date)
    end

    job.update(install_start_date: start_date, install_end_date: end_date, crew_id: crew_id)

    render json: { status: 'success' }, status: :ok
  rescue => e
    render json: { status: 'error', message: e.message }, status: :unprocessable_entity
  end

  def unassign_job
    assignment = Assignment.find_by(id: params[:assignment_id])

    if assignment
      job = assignment.job
      assignment.destroy
      if job.assignments.empty?
        job.update(crew: nil, install_start_date: nil, install_end_date: nil)
      end

      render json: { status: 'success' }, status: :ok
    else
      render json: { status: 'error', message: 'Assignment not found' }, status: :not_found
    end
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:job_number, :customer_name, :address, :customer_phone, :customer_email, :total_amount, :type_of_work, :salesman_id, :city, :state, :country, :crew_id)
  end

  def authorize_user!
    redirect_to root_path, alert: 'Not authorized' unless @job.salesman == current_user || current_user.super_admin?
  end

  def authorize_super_admin
    redirect_to root_path, alert: 'Not authorized' unless current_user.super_admin?
  end

  def sort_column
    case params[:sort]
    when 'job_number', 'customer_name', 'created_at'
      params[:sort]
    when 'salesman'
      'users.name'
    else
      'created_at'
    end
  end
  

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
