Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get :ping, to: 'api/v1/ping#index', constraints: { format: 'json' }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :ping, only: :index
      get 'gramemes_by_form/:form' => 'gramemes_by_form#show'
      get 'gramemes_by_text/:text' => 'gramemes_by_text#show'
      get 'forms_by_gramemes/:grammemes' => 'forms_by_gramemes#show',
          constraints: { grammemes: /[\w,]+/ } # слово1,слово2
      get 'lemmas_by_gramemes/:grammemes' => 'lemmas_by_gramemes#show',
          constraints: { grammemes: /[\w,]+/ } # слово1,слово2
    end
  end
end
