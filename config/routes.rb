Rails.application.routes.draw do
  # get 'home/index'
  # get '#albums', to: "albums/get_albums"
  resources :styles do
    patch :shift
  end

  resources :favorites

  resources :albums
  # get'execute/left_arrow', to home#update_styles_left
  # get 'styles/', to: 'styles#edit', as: 'edit_styles'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
