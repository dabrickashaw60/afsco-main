class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appointment, only: [:show, :destroy]
  before_action :authorize_user!, only: [:destroy]

  def index
    @appointments = Appointment.order(start_time: :asc)
    @past_appointments = Appointment.where('end_time < ?', Time.now).order(start_time: :desc)
    @upcoming_appointments = Appointment.where('start_time >= ? AND start_time <= ?', Time.now, Time.now + 7.days).order(start_time: :asc)
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
