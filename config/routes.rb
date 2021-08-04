Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }
  namespace :admin do
    resources :prompts
  end

  resources :prompts, only: [:index] do
    get "/race", to: "races#new", as: :races_new
    post "/complete-race", to: "races#complete", as: :races_complete
  end

  root to: 'prompts#index'
end
