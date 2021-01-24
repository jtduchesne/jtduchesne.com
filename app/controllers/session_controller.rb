class SessionController < ApplicationController
  layout 'jumbotron'

  # GET /login
  def new
    @user = User.new
  end

  # POST /login
  def create
    @user = User.find_or_initialize_by(user_params)
    
    if @user.verified?
      prepare_for_connection @user
      render :connect
    elsif @user.persisted?
      render :created
    elsif @user.save
      prepare_for_verification @user
      render :created
    else
      render :new
    end
  end
  
  # PUT/PATCH /login
  def update
    @user = User.find_by!(user_params)
    
    if @user.verified?
      if @user.authenticate(params[:otp])
        login @user
        redirect_to root_url(locale: params[:locale])
      else
        render :connect
      end
    else
      if ActiveRecord::Type::Boolean.new.cast(params[:send])
        prepare_for_verification @user
      end
      render :created
    end
    
  rescue ActiveRecord::RecordNotFound
    redirect_to action: :new
  end

  # DELETE /login
  def destroy
    logout
    redirect_to root_url(locale: params[:locale])
  end

  # GET /:token
  def verify
    if @user = User.verify!(params[:token])
      prepare_for_connection @user
      render :verified
    else
      flash.alert = t('.failure')
      redirect_to root_url(locale: params[:locale])
    end
  end

private
  def user_params
    params.require(:user).permit(:email)
  end
  
  def login(user)
    self.current_user = user
    flash.notice = t('logged_in') if user.try(:id)
  end
  def logout
    self.current_user = nil
    flash.notice = t('logged_out')
  end
  
  def prepare_for_verification(user)
    user.touch unless user.previously_new_record?
    UserMailer.with(user: user).verification.deliver_later
    flash.now.notice = t('email.sent', email: user.email)
    @email_sent = true
  end
  def prepare_for_connection(user)
    user.generate_onetime_password unless user.otp.present?
    UserMailer.with(user: user, otp: user.otp).connection.deliver_later
    flash.now.notice = t('email.sent', email: user.email)
    @email_sent = true
  end
end
