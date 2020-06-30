Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  #resources :days 
  #
  resources :journals, only: [:index, :show] do
    resources :notes, only: [:create, :new, :edit, :update]
  end

  root 'journals#index'

  #root 'days#show'
end
