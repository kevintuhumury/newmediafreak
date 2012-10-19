Newmediafreak::Application.routes.draw do

  resources :articles, only: [:index, :show], path: "artikel"
  resources :tags, only: [ :show ], path: "tag"

  root to: "articles#index"

  match "/404", to: "errors#render_error"
  match "/500", to: "errors#render_error"

  # match legacy permalinks
  match "/:year/:month/:day/:id", to: "articles#show", constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ }

end
