Rails.application.routes.draw do
  resources :messages, only: [:show, :edit, :create, :update, :index, :destroy] do
    get "reply" => "messages#reply"
    post "create_reply" => "messages#create_reply"
  end

  get "search", as: :meals_search, controller: :meals

  resources :meals do
    resources :messages, only: [:new]
    get :flag
  end
  get "/pages/*id" => 'pages#show', as: :page, format: false

  resource :dashboard, only: :show

  devise_for :users, controllers: {sessions: 'users/sessions', registrations: 'users/registrations'} do

  end
  get ":slug" => 'profiles#show', as: :profiles

  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :meals do
        get :flag
      end
      resources :search
      resources :sessions, only: [:create]
      resources :messages
      resources :streams
      devise_for :users, controllers: {registrations: 'api/v1/registrations'}
    end

  end

  root to: "dashboards#home_page_redirecter"
end
