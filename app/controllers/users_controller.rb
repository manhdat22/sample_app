class UsersController < ApplicationController
  before_action :logged_in_user, except: [:new, :show, :create]
  before_action :find_user_by_id, except: [:index, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :verify_admin, only: [:delete]

  def index
    @users = User.select(:id,:name,:email)
      .order(id: :asc)
      .page(params[:page])
      .per Settings.kaminari.default_per_page
  end

  def new
    @user = User.new
  end

  def show; end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "flash_update_success"
      redirect_to @user
    else
      render :edit
    end
  end

  def create
    @user = User.new user_params
    if @user.save
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = t "flash_info_activate_mail_sended"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if @user.delete
      flash[:success] = t "flash_success_deleted"
      redirect_to users_path
    else
      flash[:can_not_delete_user] = t "flash_can_not_delete_user"
      redirect_to users_path
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:not_logged_in] = t "flash_not_logged_in"
      redirect_to login_path
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def find_user_by_id
    @user = User.find_by_id(params[:id])
    if @user.nil?
      flash[:user_not_found] = t "flash_user_not_found"
      redirect_to root_path
    end
  end

  def verify_admin
    redirect_to(root_path) unless current_user.admin?
  end
end
