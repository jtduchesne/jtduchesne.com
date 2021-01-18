Rails.application.routes.draw do
  scope "(:locale)/", locale: /fr|en/ do
    root 'home#index'
  end
  
  scope locale: 'fr', path_names: {new: "nouveau", edit: "modifier"} do
    get    '/connexion',   to: 'session#new',     as: "fr_login"
    post   '/connexion',   to: 'session#create',  as: ""
    delete '/connexion',   to: 'session#destroy', as: ""
    get    '/déconnexion', to: 'session#destroy', as: "fr_logout"
    
    resources :users, path: "utilisateurs", as: "fr_users", format: false
  end
  scope locale: 'en' do
    get    '/login',  to: 'session#new',     as: "en_login"
    post   '/login',  to: 'session#create',  as: ""
    delete '/login',  to: 'session#destroy', as: ""
    get    '/logout', to: 'session#destroy', as: "en_logout"
    
    resources :users, as: "en_users", format: false
  end
  
  scope path_names: {new: "nouveau", edit: "modifier"} do
    get    '/connexion',   to: 'session#new',     as: "login"
    post   '/connexion',   to: 'session#create',  as: ""
    delete '/connexion',   to: 'session#destroy', as: ""
    get    '/déconnexion', to: 'session#destroy', as: "logout"
    
    resources :users, path: "utilisateurs", format: false
  end
end
