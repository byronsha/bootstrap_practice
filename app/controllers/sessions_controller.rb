class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )

    if @user.nil?
      flash[:errors] = "Invalid username or password"
      redirect_to new_session_url
    else
      login!(@user)
      redirect_to user_url(@user)
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end

  # def user_params
  #   params.require(:user).permit(:username, :password)
  # end


end
