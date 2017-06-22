class SessionsController < ApplicationController

  def new
  end

  def create
    if @user = User.find_by(email: params[:email])
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        render 'new'
      end
    else
      redirect_to action: 'new', show_hint: true
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
