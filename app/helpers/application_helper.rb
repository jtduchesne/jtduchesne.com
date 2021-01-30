module ApplicationHelper
  def url_for_form(model)
    model.new_record? ? url_for(action: :create) : url_for(action: :update, id: model)
  end
  
  def home_path
    url_for(controller: '/home', action: 'index')
  end
  def about_path
    url_for(controller: '/home', action: 'about')
  end
  
  def active_if(url)
    "active" if current_page?(url)
  end
end
