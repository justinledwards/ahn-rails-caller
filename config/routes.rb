Qacaller::Application.routes.draw do

#create routes to allow POST to index without trying to create a new record in a db
  match 'calls/index' => 'calls#index', :via => [:get, :post]
  resources :calls, :except => :create 
 
  root :to => 'calls#index'

end
