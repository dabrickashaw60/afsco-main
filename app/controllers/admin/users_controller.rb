class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_super_admin, except: [:index]

  def index
    @users = User.order(params[:sort] || :role)
  end

  def new
    @user = User.new
  end

def edit
  @user = User.find(params[:id])
end

  def create
    @user = User.new(user_params)

    if @user.password.blank?
      @user.password = nil
      @user.password_confirmation = nil
    end

    if @user.save
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role)
  end

  def account_update_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :current_password, :role)
  end

  def authorize_super_admin
    redirect_to root_path, alert: 'Not authorized' unless current_user.super_admin?
  end
end
