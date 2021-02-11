class Admin::AdminController < Admin::ApplicationController

  # GET /admin
  def index
    @messages = Message.all
    
    @posts = Post.all
    @projects = Project.all
    @abouts = About.all
    @users = User.all
  end

end
