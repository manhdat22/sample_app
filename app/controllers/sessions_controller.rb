class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:sessions][:email].downcase)
    if user && user.authenticate(params[:sessions][:password])
      log_in user
      redirect_to user
    else
      flash.now[:invalid_login] = t ".flash_invalid_login"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end


end
