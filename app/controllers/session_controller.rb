class SessionController < ApplicationController
  layout 'jumbotron'

  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    @user = User.find_or_initialize_by(params.require(:user).permit(:email))
    
    if @user.verified?
      login @user
    elsif @user.persisted?
      ask_to_check_email @user
    elsif @user.save
      prepare_for_verification @user
    else
      render :new and return
    end
    
    redirect_to root_url(locale: params[:locale])
  end

  # DELETE /login
  def destroy
    logout
    redirect_to root_url(locale: params[:locale])
  end

  # GET /:token
  def verify
    if User.verify!(params[:token])
      flash.notice = t('.success')
    else
      flash.alert = t('.failure')
    end
    redirect_to action: 'new'
  end

private
  def login(user)
    self.current_user = user
    flash.notice = t('logged_in') if user.try(:id)
  end
  def logout
    self.current_user = nil
    flash.notice = t('logged_out')
  end
  
  def ask_to_check_email(user)
    flash.alert = t('session.email.already_sent', email: user.email,
                                                  time_ago: helpers.time_ago_in_words(user.updated_at))
  end
  def prepare_for_verification(user)
    UserMailer.with(user: user).verification.deliver_later
    flash.notice = t('session.email.sent', email: user.email)
  end
end
