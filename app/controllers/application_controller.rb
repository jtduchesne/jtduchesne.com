class ApplicationController < ActionController::Base
  before_action :set_locale
  
  def default_url_options
    { locale: I18n.locale.to_s }
  end
  
  def f(model)
    t(action_name, scope: 'activerecord', model: model.model_name.human)
  end
  
protected
  def require_login
    unless logged_in?
      cookies[:referer] = {
        value: request.url,
        expires: 30.minutes
      }
      redirect_to controller: '/session', action: 'new'
    end
  end
  def require_admin
    unless require_login
      redirect_to root_url(locale: params[:locale]) unless logged_in_as_admin?
    end
  end
  
  def current_user
    if @current_user.nil?
      @current_user = session[:user_id] ? User.find(session[:user_id]) : false
    end
    @current_user
  end
  def current_user=(user)
    reset_session
    if user
      @current_user = user
      session[:user_id] = user.id
    else
      @current_user = false
    end
  end
  helper_method :current_user
  
  def logged_in?
    !!current_user
  end
  def logged_out?
    !current_user
  end
  def logged_in_as_admin?
    logged_in? && current_user.admin?
  end
  helper_method :logged_in?, :logged_out?, :logged_in_as_admin?
  
private
  def set_locale
    locale = params[:locale]
    if locale.present?
      I18n.locale = locale
      
      if locale == preferred_language
        params[:locale] = nil
      end
    else
      I18n.locale = preferred_language || I18n.default_locale
    end
  end
  
  def preferred_language
    request.headers['HTTP_ACCEPT_LANGUAGE'] &&
    request.headers['HTTP_ACCEPT_LANGUAGE'].scan(/fr|en/i).first
  end
end
