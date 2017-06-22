class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Welcome! Signed in."
        flash.keep
        redirect_to root_path
      else
        flash.now[:error] = "Wrong password!"
        flash.keep
        render 'new'
      end
    else
      flash.now[:error] = "User not found."
      flash.keep
      redirect_to action: 'new', show_hint: true
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
