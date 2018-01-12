class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by_email params[:email]
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "flash_account_activated"
      redirect_to user
    else
      flash[:invalid_activation_link] = t "flash_invalid_activation_link"
      redirect_to root_path
    end
  end
end
