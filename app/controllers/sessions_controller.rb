class SessionsController < ApplicationController
	def index
	end

	def new
	end

	def create
		user = login(params[:email], params[:password])

		if user
			flash[:notice] = "Welcome back!"
			redirect_back_or_to root_url
		else
			flash.now[:error] = "Email or password not found"
			render 'new'
		end
	end

	def destroy
		logout
		flash[:notice] = "Bye!"
		redirect_to root_url
	end
end
