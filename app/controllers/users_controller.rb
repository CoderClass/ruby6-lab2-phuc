class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def index
    @users = User.all.shuffle
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome #{@user.name}"
      session[:user_id] = @user.id
      redirect_to users_path
    else
      flash[:error] = "Error: #{@user.errors.full_messages.to_sentence}"
      redirect_to new_user_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
