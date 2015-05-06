Rails.application.routes.draw do

 resources :agents, except: [:new, :edit] do
   member do
     get 'current_project'
   end

   resources :projects, except: [:new, :edit]
 end

 resources :tasks, except: [:new, :edit]

 resources :projects, except: [:new, :edit] do
   resources :tasks, except: [:new, :edit]
 end

end
