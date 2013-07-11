class My::ProjectsController < ApplicationController
  before_filter :require_login

  def index
    @projects = Project.where(user: current_user)
  end

  def show
    @project = Project.find(params[:id])
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(
      title: params[:project][:title],
      teaser: params[:project][:teaser],
      description: params[:project][:description],
      goal: params[:project][:goal],
      user: current_user
      )

    if @project.save
      redirect_to my_projects_path, notice: "Success!"
    else
      flash.now[:error] = "Sorry, something went wrong."
      render 'new'
    end
  end

  def edit
    @project = Project.find(params[:id])
    if @project.user != current_user
      flash[:error] = "You cannot edit other users' projects"
      redirect_to projects_path
    end
  end

  def update
    @project = Project.find(params[:id])

    if @project.update_attributes(
      title: params[:project][:title],
      teaser: params[:project][:teaser],
      description: params[:project][:description],
      goal: params[:project][:goal],
      user: current_user
      )
      redirect_to my_projects_path
    else
      render 'edit'
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
  end

  protected 
end
