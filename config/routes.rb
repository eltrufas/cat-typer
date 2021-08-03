Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :prompts
  end

  resources :prompts, only: [:index] do
    get "/race", to: "races#new", as: :races_new
    post "/complete-race", to: "races#complete", as: :races_complete
  end

  root to: 'prompts#index'

  post "/webhooks/challenges", to: "challenges#webhook"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
