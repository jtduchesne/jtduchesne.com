module HomeHelper
  def active_if(url)
    "active" if current_page?(url)
  end
end
