class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: "Thanks for signing up!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if session[:user_id] && session[:user_id] == params[:id].to_i
      @user = User.find(params[:id])
      @user.destroy
      session[:user_id] = nil
      redirect_to users_path, status: :see_other, notice: "User deleted successfully."
    else
      redirect_to users_path, status: :see_other, alert: "You can only delete your own account."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
