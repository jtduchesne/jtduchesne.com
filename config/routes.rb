Rails.application.routes.draw do
  scope "(:locale)/", locale: /fr|en/ do
    root 'home#index'
  end
  
  resources :users, format: false
end
