Rails.application.routes.draw do
  TOKEN_REGEXP = /[A-Za-z1-9=]{24}/.freeze unless defined?(TOKEN_REGEXP)
  
  scope "(:locale)/", locale: /fr|en/ do
    root 'home#posts'
  end
  scope "/admin/(:locale)/", locale: /fr|en/ do
    root 'admin/admin#index', as: "admin"
  end
  
  scope locale: 'fr', path_names: {new: "nouveau", edit: "modifier"} do
    get  '/projets',     to: 'home#projects', as: "fr_projects"
    get  '/projets/:id', to: 'home#project',  as: "fr_project"
    get  '/contacter', to: 'messages#new',    as: "fr_contact"
    post '/contacter', to: 'messages#create', as: ""
    get  '/à-propos',  to: 'home#about',      as: "fr_about"
    
    get    '/connexion',   to: 'session#new',     as: "fr_login"
    post   '/connexion',   to: 'session#create',  as: ""
    patch  '/connexion',   to: 'session#update',  as: ""
    delete '/connexion',   to: 'session#destroy', as: ""
    get    '/déconnexion', to: 'session#destroy', as: "fr_logout"
    
    scope '/admin', module: 'admin' do
      resources :posts,    path: "articles",    as: "fr_admin_posts"
      resources :projects, path: "projets",     as: "fr_admin_projects"
      resources :messages, path: "messages/fr", as: "fr_admin_messages", except: [:edit, :update]
      resources :abouts,  path: "à-propos",     as: "fr_admin_abouts"
      resources :users,   path: "utilisateurs", as: "fr_admin_users", format: false
    end
    
    get '/fr/:token', to: 'session#verify', as: "fr_verification", token: TOKEN_REGEXP
    
    get '/fr/:id', to: 'home#post', as: "fr_post"
  end
  scope locale: 'en' do
    get  '/projects',     to: 'home#projects', as: "en_projects"
    get  '/projects/:id', to: 'home#project',  as: "en_project"
    get  '/contact', to: 'messages#new',    as: "en_contact"
    post '/contact', to: 'messages#create', as: ""
    get  '/about',   to: 'home#about',      as: "en_about"
    
    get    '/login',  to: 'session#new',     as: "en_login"
    post   '/login',  to: 'session#create',  as: ""
    patch  '/login',  to: 'session#update',  as: ""
    delete '/login',  to: 'session#destroy', as: ""
    get    '/logout', to: 'session#destroy', as: "en_logout"
    
    scope '/admin', module: 'admin' do
      resources :posts,    as: "en_admin_posts"
      resources :projects, as: "en_admin_projects"
      resources :messages, as: "en_admin_messages", path: "messages/en", except: [:edit, :update]
      resources :abouts,   as: "en_admin_abouts"
      resources :users,    as: "en_admin_users", format: false
    end
    
    get '/en/:token', to: 'session#verify', as: "en_verification", token: TOKEN_REGEXP
    
    get '/en/:id', to: 'home#post', as: "en_post"
  end
  
  scope path_names: {new: "nouveau", edit: "modifier"} do
    get  '/projets',     to: 'home#projects', as: "projects"
    get  '/projets/:id', to: 'home#project',  as: "project"
    get  '/contacter', to: 'messages#new',    as: "contact"
    post '/contacter', to: 'messages#create', as: ""
    get  '/à-propos',  to: 'home#about',      as: "about"
    
    get    '/connexion',   to: 'session#new',     as: "login"
    post   '/connexion',   to: 'session#create',  as: ""
    patch  '/connexion',   to: 'session#update',  as: ""
    delete '/connexion',   to: 'session#destroy', as: ""
    get    '/déconnexion', to: 'session#destroy', as: "logout"
    
    namespace 'admin' do
      resources :posts,    path: "articles"
      resources :projects, path: "projets"
      resources :messages, path: "messages/fr", except: [:edit, :update]
      resources :abouts,   path: "à-propos"
      resources :users,    path: "utilisateurs", format: false
    end
    
    get '/:token', to: 'session#verify', as: "verification", token: TOKEN_REGEXP
    
    get '/:id', to: 'home#post', as: "post"
  end
end
