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
  
  def relative_date(time)
    date = time.to_date
    if date >= Date.yesterday
      time_ago = l(time, format: :short)
    else
      time_ago = time_ago_in_words(time)
    end
    t('relative_date', scope: 'datetime.distance_in_words', count: (Date.today - date), time_ago: time_ago)
  end
end
