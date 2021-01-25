class Admin::AdminController < ApplicationController
  before_action :require_admin

  layout 'jumbotron'

  # GET /admin
  def index
    @users = User.all
  end

end
