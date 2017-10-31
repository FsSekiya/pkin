Rails.application.routes.draw do
  mount_devise_token_auth_for 'Worker', at: 'auth'
  get 'sample/starter'

  namespace :customer do
    resources :dashboard
  end
end
