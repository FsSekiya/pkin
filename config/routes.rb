Rails.application.routes.draw do
  mount_devise_token_auth_for 'Worker', at: 'auth'
  get 'sample/starter'

  devise_for :customer, controllers: {
    sessions: 'customer/sessions'
  }
  devise_scope :customer do
    root to: 'customer/sessions#new'
  end

  namespace :customer do
    resources :dashboard
  end
end
