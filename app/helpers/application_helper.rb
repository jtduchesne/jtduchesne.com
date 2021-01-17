module ApplicationHelper
  def url_for_form(model)
    model.new_record? ? url_for(action: :create) : url_for(action: :update, id: model)
  end
end
