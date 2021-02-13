module UrlHelper
  def url_for_form(model)
    model.new_record? ? url_for(action: 'create') : url_for(action: 'update', id: model)
  end
  
  def blog_path
    url_for(controller: '/home', action: 'posts')
  end
  def projects_path
    url_for(controller: '/home', action: 'projects')
  end
  def contact_path
    url_for(controller: '/messages', action: 'new')
  end
  def about_path
    url_for(controller: '/home', action: 'about')
  end
end
