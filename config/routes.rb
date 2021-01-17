Rails.application.routes.draw do
  scope "(:locale)/", locale: /fr|en/ do
    root 'home#index'
  end
  
  scope locale: 'fr', path_names: {new: "nouveau", edit: "modifier"} do
    resources :users, path: "utilisateurs", as: "fr_users", format: false
  end
  scope locale: 'en' do
    resources :users, as: "en_users", format: false
  end
  
  scope path_names: {new: "nouveau", edit: "modifier"} do
    resources :users, path: "utilisateurs", format: false
  end
end
