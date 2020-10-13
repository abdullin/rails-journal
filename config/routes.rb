Rails.application.routes.draw do
  get 'review/week'
  get 'review/day'
  get 'review/future'

  get 'home', to: 'home#index'
  get 'home/shelf', to: 'home#shelf'


  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :journals, only: [:show, :edit, :update] do
    member do
      get :future, :shelve, :files
    end
    resources :notes, only: [:create, :new]
  end

  resources :notes, only: [:show, :edit, :update, :destroy]
  resources :inbox, only: [:create, :new, :index, :move, :destroy]

  resources :people, only: [:show]

  # only mentionable
  resources :mentions, only: [:index]

end
