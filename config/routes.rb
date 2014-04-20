Newmediafreak::Application.routes.draw do

  mount Kuva::Engine => "/fotografie"

  resources :articles, only: [:index, :show], path: "artikel"
  resources :tags, only: [ :show ], path: "tag"

  root to: "articles#index"

  get "/404", to: "errors#render_error"
  get "/500", to: "errors#render_error"

  # match legacy permalinks
  get "/:year/:month/:day/:id", to: "articles#show", constraints: { year: /\d{4}/, month: /\d{2}/, day: /\d{2}/ }

end
