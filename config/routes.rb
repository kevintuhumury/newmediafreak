Newmediafreak::Application.routes.draw do

  resources :articles, only: [:index, :show], path: "artikel"
  root :to => 'articles#index'

  match "/404", :to => "errors#not_found"

  # match legacy permalinks
  match "/:year/:month/:day/:id", to: "articles#show", constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ }
end
