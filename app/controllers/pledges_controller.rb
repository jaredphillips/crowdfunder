class PledgesController < ApplicationController
  before_filter :load_project
  before_filter :require_login, only: [:new, :create]

	def index
	end

	def new
		@pledge = Pledge.new
	end

	def create
		@pledge = Pledge.new(
			user_id: current_user.id, 
			project_id: @project.id,
			amount: params[:pledge][:amount])
		
		if @pledge.save
			flash[:notice] = "Thanks for supporting this project!"
			redirect_to @project
		else
			render 'new'
		end
	end

	def destroy
	end

	protected

			def load_project
				@project = Project.find(params[:project_id])
			end

			def not_authenticated
				redirect_to login_path, alert: "You must login to pledge!"
			end

end
