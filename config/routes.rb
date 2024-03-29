Rails.application.routes.draw do
  apipie
  devise_for :users,
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  namespace :api do
    namespace :v1 do
      resources :projects do
        resources :tasks
      end
      resources :users, only: %i[index]
    end
  end
end
