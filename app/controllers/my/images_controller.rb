class My::ImagesController < ApplicationController
  before_filter :load_project

  def index
    @images = @project.images
  end

  def new
    @image = @project.images.build
  end


  protected 

      def load_project
        @project = Project.find(params[:project_id])
      end

end
