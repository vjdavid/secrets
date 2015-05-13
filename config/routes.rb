Rails.application.routes.draw do

 post 'register', to: 'authentication#register'
 post 'login', to: 'authentication#login'
 post 'logout', to: 'authentication#logout'

 resources :agents do
   member do
     get 'current_project'
   end

   resources :projects
 end

 resources :tasks

 resources :projects do
   resources :tasks
 end

end
