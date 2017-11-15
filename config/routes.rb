Rails.application.routes.draw do
  devise_for :customers, controllers: {
    sessions: 'customers/sessions'
  }, skip: %i[registration passwords]
  devise_scope :customer do
    root to: 'customers/sessions#new'
  end

  namespace :customers do
    resources :dashboard
    resources :branch, only: %i[show]
    resources :setting, only: %i[index]
    resources :worker, only: %i[new create]
    resources :record, only: %i[show]
  end

  namespace :api, defaults: { format: :json } do
    namespace :worker do
      mount_devise_token_auth_for 'Worker', at: 'auth',
                                            only: %i[sign_in sign_out session],
                                            controllers: {
                                              sessions: 'api/worker/sessions'
                                            }, skip: %i[registration passwords]
    end

    namespace :qr do
      resources :key, only: [:index]
    end
  end
end
