Rails.application.routes.draw do
  get 'review/week'
  get 'review/day'
  get 'review/future'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :journals, only: [:index, :show, :edit, :update] do
    member do
      get :future
    end
    resources :notes, only: [:create, :new, :edit, :update, :destroy]
  end

  resources :people, only: [:index, :show]

  # only mentionable
  resources :mentions, only: [:index]

  root 'journals#index'
end
