Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get :ping, to: 'api/v1/ping#index', constraints: { format: 'json' }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ping, only: :index
      get 'gramemes_by_form/:form' => 'gramemes_by_form#index'
    end
  end
end
