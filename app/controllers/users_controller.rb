class UsersController < ApplicationController

  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user, only: [:edit, :update, :destroy]

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
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    redirect_to users_path, status: :see_other, notice: "User deleted successfully."
  end

  private

  def require_correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      redirect_to users_path, alert: "You can only edit your own account."
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
