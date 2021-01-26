class Admin::AdminController < ApplicationController
  before_action :require_admin

  layout 'jumbotron'

  # GET /admin
  def index
    @abouts = About.all
    @users = User.all
  end

end
