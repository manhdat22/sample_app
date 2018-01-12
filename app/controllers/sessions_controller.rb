class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == "1" ? remember(user) : forget(user)
        remember user
        redirect_back_or user
      else
        flash[:warning] = t "flash_account_not_activated"
        redirect_to root_path
      end
    else
      flash.now[:invalid_login] = t ".flash_invalid_login"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
