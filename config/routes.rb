Rails.application.routes.draw do
  get 'sample/starter'

  namespace :customer do
    resources :dashboard
  end
end
