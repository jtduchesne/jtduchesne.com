class ApplicationController < ActionController::Base
  before_action :set_locale
  
  def default_url_options
    { locale: I18n.locale.to_s }
  end
  
  def f(model)
    t(action_name, scope: 'activerecord', model: model.model_name.human)
  end
  
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
