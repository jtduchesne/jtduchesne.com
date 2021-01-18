class SessionController < ApplicationController
  layout 'jumbotron'

  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    @user = User.find_or_initialize_by(params.require(:user).permit(:email))
    
    if @user.persisted?
      self.current_user = @user
    elsif @user.save
      self.current_user = @user
    else
      render :new and return
    end
    
    redirect_to root_url(locale: params[:locale])
  end

  # DELETE /login
  def destroy
    self.current_user = nil
    
    redirect_to root_url(locale: params[:locale])
  end
end
