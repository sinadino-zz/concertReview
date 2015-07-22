class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  @user = User.new(user_params)
  if @user.save
    #redirect_to root_url, :notice => "Signed up!"
    redirect_to log_in_path, :notice => "Signed up!"
  else
    render "new"
  end
  end

  #add thing from http://stackoverflow.com/a/19130224/2739431
  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :location)
    end

end
