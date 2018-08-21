Rails.application.routes.draw do

  mount Kuva::Engine => '/fotografie'

  resources :articles, only: [:index, :show], path: 'artikel'
  resources :tags, only: [ :show ], path: 'tag'

  root to: 'articles#index'

  get '/404', to: 'errors#render_error'
  get '/500', to: 'errors#render_error'

end
