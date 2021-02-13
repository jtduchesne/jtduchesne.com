class HomeController < ApplicationController
  def posts
    @posts = Post.untranslated.or(Post.language(I18n.locale)).published.all.reverse_order
  end
  def post
    @post = Post.published.find_by!(slug: params[:id])
    if @post.locale != I18n.locale
      redirect_to url_for(id: @post.translated, locale: I18n.locale) unless @post.translated.nil?
    end
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
