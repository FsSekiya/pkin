Rails.application.routes.draw do
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
