Rails.application.routes.draw do

 resources :agents do
   member do
     get 'current_project'
   end
 end

end
