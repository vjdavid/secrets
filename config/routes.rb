Rails.application.routes.draw do

 resources :agents, except: [:new, :edit] do
   member do
     get 'current_project'
   end
 end

 resources :tasks, except: [:new, :edit]
 match 'tasks/:project_id' => 'tasks#index', :via => :get

 resources :projects, except: [:new, :edit]
 match 'projects/:agent_id' => 'projects#index', :via => :get

end
