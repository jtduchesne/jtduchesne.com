class HomeController < ApplicationController
  def index
  end
  
  def about
    @about = About.published.last
    render :about, layout: 'jumbotron'
  end
end
