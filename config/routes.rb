Rails.application.routes.draw do
  mount_devise_token_auth_for 'Worker', at: 'auth'
  get 'sample/starter'

  devise_for :customer, controllers: {
    sessions: 'customer/sessions'
  }, skip: %i[registration passwords]
  devise_scope :customer do
    root to: 'customer/sessions#new'
  end

  namespace :customer do
    resources :dashboard
    resources :branch, only: %i[index show]
    resources :setting, only: [:index]
    resources :record, only: [:index]
  end

  namespace :api, defaults: { format: :json } do
    namespace :qr do
      resources :key, only: [:index]
    end
  end
end
