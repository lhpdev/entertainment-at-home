Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do
      get 'movies',  to: 'movies#index'
      get 'seasons', to: 'seasons#index'
      get 'medias',  to: 'medias#index'

      resources :users do
        resources :library, only: :index
        resources :purchases, only: :create
      end
    end
  end
end
