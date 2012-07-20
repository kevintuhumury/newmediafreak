Newmediafreak::Application.routes.draw do

  resources :articles, only: [:index, :show], path: "artikel"

  root :to => 'articles#index'

end
