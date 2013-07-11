class My::ImagesController < ApplicationController
  before_filter :load_project

  def index
    @images = @project.images
  end

  def new
    @image = @project.images.build
  end

  def create
    @image = @project.images.build(
      name: params[:image][:name],
      description: params[:image][:description],
      image: params[:image][:image],
      user: current_user
    )

    if @image.save
      flash[:notice] = "Success"
      redirect_to my_project_images_path(@project)
    else
      flash.now[:error] = "Sorry, attachment must be an image."
      render 'new'
    end
  end

  protected 

      def load_project
        @project = Project.find(params[:project_id])
      end

end
