class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:new, :show, :destroy, :convert_to_job]
  before_action :authorize_user!, only: [:destroy]

  def index
    @appointments = Appointment.order(start_time: :asc)
    @todays_date = Date.current
    @start_of_today = @todays_date.beginning_of_day
    @end_of_today = @todays_date.end_of_day

    @today_appointments = Appointment.where(start_time: @start_of_today..@end_of_today)
    @past_appointments = Appointment.where("start_time < ?", @start_of_today).order(start_time: :desc).limit(3)
    @upcoming_appointments = Appointment.where("start_time > ?", @end_of_today).order(start_time: :asc).limit(3)
    @appointment = Appointment.new
  end

  def new
    @appointment = current_user.appointments.new
  end

  def show
  end

  def create
    @appointment = current_user.appointments.new(appointment_params)
    if @appointment.save
      redirect_to root_path, notice: 'Appointment was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if @appointment.present? && @appointment.user == current_user
      @appointment.destroy
      redirect_to root_path, notice: 'Appointment was successfully deleted.'
    else
      redirect_to root_path, alert: 'Appointment not found or not authorized to delete.'
    end
  end

  def convert_to_job
    job = Job.new(
      job_number: params[:job_number],
      salesman_id: @appointment.user_id,
      customer_name: params[:customer_name], # Use params to get additional fields
      address: params[:address],
      customer_phone: params[:customer_phone],
      customer_email: params[:customer_email],
      total_amount: params[:total_amount],
      type_of_work: params[:type_of_work],
      installed: false
    )
    if job.save
      @appointment.update(job_id: job.id)
      redirect_to @appointment, notice: 'Appointment was successfully converted to a job.'
    else
      redirect_to @appointment, alert: 'Failed to convert appointment to a job.'
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit(:title, :location, :start_time, :end_time, :user_id)
  end

  def authorize_user!
    redirect_to root_path, alert: 'Not authorized' unless @appointment.user == current_user
  end

  def set_appointment
    @appointment = Appointment.find(params[:id])
  end
end
