Rails.application.routes.draw do

  
  root 'static_pages#home'
  
  scope "/FAIR_Evaluator" do 
  
    get 'static_pages/home'
  
    get 'static_pages/help'
  
    get 'static_pages/about'
  
    resources :evaluations
    resources :collections   # the "resources" command auto-creates the default routes, including POST going to #create
    resources :metrics
  
     
    root 'static_pages#home'
    get '/about', to: 'static_pages#home'
    get '/interface', to: 'static_pages#interface'
    get '/terms', to: 'static_pages#tos'
    get '/license', to: 'static_pages#license'
    
    
    
    post 'collections/new', to: 'collections#create'
    post 'collections', to: 'collections#create'
    post 'collections/:id/deprecate', to: 'collections#deprecate'
    get 'collections/:id/deprecate', to: 'collections#deprecate'
    post 'metrics/:id/deprecate', to: 'metrics#deprecate'
    get 'metrics/:id/deprecate', to: 'metrics#deprecate'
    
   
    #get 'collections/:id/evaluation', to: 'evaluations#template', as: 'template'
    post 'collections/:id/evaluate', to: 'evaluations#execute_analysis'  # collections/7/evaluate
    get 'collections/:id/evaluate/template', to: 'evaluations#template'  # collections/7/evaluate
    
    post 'evaluations/:id/result', to: 'evaluations#result', as: 'result'  # I think this is more REST-like...??  posting to Result to update the state of Result?  
    get 'evaluations/:id/result', to: 'evaluations#result'
    #post 'evaluations/:id/result', to: 'evaluations#result'
    #get 'evaluations/:id/error', to: 'evaluations#error'
    
    
    # API methods
    namespace :v1, defaults: {format: 'json'} do
      scope '/users' do
        post "register" => 'users#register'
        post "auth/login", to: 'users#login'
        get "test", to: 'users#test'  # a way to test authentication without payload - are you still logged-in?
      end
    end
  
  end
  
  
end
