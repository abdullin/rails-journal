Rails.application.routes.draw do
  get 'review/week'
  get 'review/day'
  get 'review/future'

  get 'home', to: 'home#index'
  get 'home/cold', to: 'home#cold'


  root 'home#index'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :journals, only: [:show, :edit, :update] do
    member do
      get :future, :shelve
    end
    resources :notes, only: [:create, :new, :edit, :update, :destroy]
  end

  resources :people, only: [:index, :show]

  # only mentionable
  resources :mentions, only: [:index]

end
