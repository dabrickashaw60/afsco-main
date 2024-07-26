class HomeController < ApplicationController
  before_action :set_date_range, only: [:index, :installer_calendar]

  def index
    @current_month = params[:month] ? params[:month].to_i : Date.today.month
    @current_year = params[:year] ? params[:year].to_i : Date.today.year
    @view_type = params[:view] || 'monthly'
    @current_week = params[:week] ? params[:week].to_i : Date.today.cweek
    @appointments = Appointment.order(start_time: :asc)
    @past_appointments = Appointment.where('end_time < ?', Time.now).order(start_time: :desc)
    @upcoming_appointments = Appointment.where('start_time >= ? AND start_time <= ?', Time.now, Time.now + 7.days).order(start_time: :asc)
    
    case @view_type
    when 'weekly'
      @start_date = Date.commercial(@current_year, @current_week, 1)
      @end_date = Date.commercial(@current_year, @current_week, 6) # Saturday
    else
      @start_date = Date.new(@current_year, @current_month, 1).beginning_of_week(:sunday)
      @end_date = Date.new(@current_year, @current_month, -1).end_of_week(:sunday)
    end

    @appointments = Appointment.where(start_time: @start_date..@end_date).order(start_time: :asc)
  end

  def installer_calendar
    @view_type = 'weekly'
    @jobs = Job.all
    set_date_range
  end

  def map
    @jobs = Job.all
  end

  private

  def set_date_range
    if @view_type == 'weekly'
      @current_week = params[:week] ? params[:week].to_i : Date.today.cweek
      @current_year = params[:year] ? params[:year].to_i : Date.today.year
      @start_date = Date.commercial(@current_year, @current_week, 1)
      @end_date = Date.commercial(@current_year, @current_week, 6) # Saturday
    else
      @current_month = params[:month] ? params[:month].to_i : Date.today.month
      @current_year = params[:year] ? params[:year].to_i : Date.today.year
      @start_date = Date.new(@current_year, @current_month).beginning_of_month.beginning_of_week(:sunday)
      @end_date = Date.new(@current_year, @current_month).end_of_month.end_of_week(:sunday)
    end
  end
end
