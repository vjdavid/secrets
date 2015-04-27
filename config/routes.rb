Rails.application.routes.draw do

 resources :agents, except: [:new, :edit] do
   member do
     get 'current_project'
   end
 end

 resources :tasks, except: [:new, :edit] do
   member do
     get 'project_id'
   end
 end

 resources :projects, except: [:new, :edit] do
   member do
     get 'agent_id'
   end
 end


end
