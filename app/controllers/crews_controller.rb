class CrewsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin
  helper :application


  def index
    @crews = Crew.all
  end

  def new
    @crew = Crew.new
    @users = User.where(role: 'installer')
  end

  def create
    @crew = Crew.new(crew_params)
    if @crew.save
      redirect_to crews_path, notice: 'Crew was successfully created.'
    else
      @users = User.all
      render :new
    end
  end

  def edit
    @crew = Crew.find(params[:id])
    @users = User.where(role: 'installer')
  end

  def update
    @crew = Crew.find(params[:id])
    if @crew.update(crew_params)
      redirect_to crews_path, notice: 'Crew was successfully updated.'
    else
      @users = User.all
      render :edit
    end
  end

  def destroy
    @crew = Crew.find(params[:id])
    @crew.destroy
    redirect_to crews_path, notice: 'Crew was successfully deleted.'
  end

  private

  def crew_params
    params.require(:crew).permit(:name, :foreman_id, :laborer1_id, :laborer2_id)
  end

  def authorize_super_admin
    redirect_to root_path, alert: 'Not authorized' unless current_user.super_admin?
  end
end

