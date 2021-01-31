Rails.application.routes.draw do
  TOKEN_REGEXP = /[A-Za-z1-9=]{24}/.freeze unless defined?(TOKEN_REGEXP)
  
  scope "(:locale)/", locale: /fr|en/ do
    root 'home#index'
  end
  scope "/admin/(:locale)/", locale: /fr|en/ do
    root 'admin/admin#index', as: "admin"
  end
  
  namespace :admin do
    resources :messages
  end
  
  scope locale: 'fr', path_names: {new: "nouveau", edit: "modifier"} do
    get '/à-propos', to: 'home#about', as: "fr_about"
    
    get    '/connexion',   to: 'session#new',     as: "fr_login"
    post   '/connexion',   to: 'session#create',  as: ""
    patch  '/connexion',   to: 'session#update',  as: ""
    delete '/connexion',   to: 'session#destroy', as: ""
    get    '/déconnexion', to: 'session#destroy', as: "fr_logout"
    
    scope '/admin', module: 'admin' do
      resources :abouts, path: "à-propos",     as: "fr_admin_abouts"
      resources :users,  path: "utilisateurs", as: "fr_admin_users", format: false
    end
    
    get '/fr/:token', to: 'session#verify', as: "fr_verification", token: TOKEN_REGEXP
  end
  scope locale: 'en' do
    get '/about', to: 'home#about', as: "en_about"
    
    get    '/login',  to: 'session#new',     as: "en_login"
    post   '/login',  to: 'session#create',  as: ""
    patch  '/login',  to: 'session#update',  as: ""
    delete '/login',  to: 'session#destroy', as: ""
    get    '/logout', to: 'session#destroy', as: "en_logout"
    
    scope '/admin', module: 'admin' do
      resources :abouts, as: "en_admin_abouts"
      resources :users,  as: "en_admin_users", format: false
    end
    
    get '/en/:token', to: 'session#verify', as: "en_verification", token: TOKEN_REGEXP
  end
  
  scope path_names: {new: "nouveau", edit: "modifier"} do
    get '/à-propos', to: 'home#about', as: "about"
    
    get    '/connexion',   to: 'session#new',     as: "login"
    post   '/connexion',   to: 'session#create',  as: ""
    patch  '/connexion',   to: 'session#update',  as: ""
    delete '/connexion',   to: 'session#destroy', as: ""
    get    '/déconnexion', to: 'session#destroy', as: "logout"
    
    namespace 'admin' do
      resources :abouts, path: "à-propos"
      resources :users,  path: "utilisateurs", format: false
    end
    
    get '/:token', to: 'session#verify', as: "verification", token: TOKEN_REGEXP
  end
end
