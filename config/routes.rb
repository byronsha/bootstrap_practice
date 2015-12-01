Rails.application.routes.draw do
  root to: redirect("session/new")

  controller :pages do
    get :home
    get :about
    get :contact
  end

  resources :users
  resources :heroes, only: [:index, :show]
  resource :session

  resources :subs, except: [:destroy] do
    resources :posts, except: [:index]
  end
end
