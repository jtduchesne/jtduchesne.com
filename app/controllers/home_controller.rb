class HomeController < ApplicationController
  def index
  end
  
  def projects
    @projects = Project.includes(:tags).all
    render :projects, layout: 'jumbotron'
  end
  def project
    @project = Project.find_by(slug: params[:id])
    render :project, layout: 'jumbotron'
  end
  
  def about
    @about = About.published.last
    render :about, layout: 'jumbotron'
  end
end
