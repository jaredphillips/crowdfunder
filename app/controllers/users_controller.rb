class UsersController < ApplicationController
  def index
  end

  def new
  	@user = User.new
  end

  def create
  	@user = User.create(user_params)

    if @user.save
      flash[:notice] = "Account Created!"
      redirect_to root_path
  	else
      flash.now[:alert] = "Try again!"
      render 'new'
    end
  end

  private

  		def user_params
  			params.require(:user).permit(:first_name, :last_name, :email, :password)
  		end
end
