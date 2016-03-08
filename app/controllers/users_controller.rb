class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Logged In.'
    else
      flash[:alert] = 'Check errors and try again.'
      render :new
    end
  end

  def edit
  end

  def update
    current_user.update user_params
    redirect_to root_path, notice: 'Account Updated.'
  end

  def edit_password
  end

  def update_password
    if diff_pass? && auth_pass? && confirmed_pass? && empty_check?
      current_user.update password: user_params[:new_password]
      redirect_to root_path, notice: 'Password Changed.'
    else
      flash[:alert] = 'Please Try Again.'
      render :edit_password
    end
  end

  private
  def empty_check?
    (user_params[:new_password] || user_params[:password_confirmation]) != '' || nil
  end

  def confirmed_pass?
    user_params[:new_password] == user_params[:password_confirmation]
  end

  def diff_pass?
    user_params[:new_password] != user_params[:password]
  end

  def auth_pass?
    current_user.authenticate(user_params[:password])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :new_password)
  end
end
