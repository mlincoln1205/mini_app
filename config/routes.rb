Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :tasks do
    resources :comments, only: %i[index new create]
  end
  resources :task_reports, only: [:index]


  resources :profiles, only: %i[show new create update edit] do
    get 'private_page', on: :member
    post 'change_privacy', on: :member
    resources :comments, only: %i[index]
  end

  resources :pluses, only: %i[create destroy]
  resources :minuses, only: %i[create destroy]
end
