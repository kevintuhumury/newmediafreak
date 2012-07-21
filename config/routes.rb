Newmediafreak::Application.routes.draw do

  resources :articles, only: [:index, :show], path: "artikel"
  root :to => 'articles#index'

  match "/404", :to => "errors#not_found"
end
