Rails.application.routes.draw do

  resources :static, only: [] do
    collection do
      get :help
      get :help_detail
      get :notification
      get :notification_detail
      get :terms
      get :privacy
    end
  end
    
  devise_for :customer, controllers: {
    sessions: 'customer/sessions'
  }, skip: %i[registration passwords], class_name: 'Customer'
  devise_scope :customer do
    root to: 'customer/sessions#new'
  end

  devise_for :admin, controllers: {
    sessions: 'admin/sessions'
  }, skip: %i[registration passwords], class_name: 'Admin'

  namespace :admin do
    resources :dashboard
    resources :apply, only: %i[index] do
      collection do
        get :csv
      end
    end
    resources :customer, only: %i[index] do
      member do
        get :login_customer
      end
    end
  end

  namespace :customer do
    resources :dashboard
    resources :branch, only: %i[show]
    resources :setting, only: %i[index]
    resources :worker, only: %i[new create]
    resources :working_record, only: %i[update]
    resources :apply, only: %i[show]
  end

  namespace :api, defaults: { format: :json } do
    namespace :worker do
      mount_devise_token_auth_for 'Worker', at: 'auth',
                                            only: %i[sign_in sign_out session],
                                            controllers: {
                                              sessions: 'api/worker/sessions'
                                            }, skip: %i[registration passwords]
      resources :working_record, only: [] do
        collection do
          get :amount
          get :is_working
          get :paid_amounts
          post :start
          post :finish
        end
      end

      resources :application_status, only: [] do
        collection do
          get :application_status
        end
      end

      resources :apply, only: [] do
        collection do
          post :create
        end
      end

      resources :profile, only: [:index] do
      end
    end

    namespace :qr do
      resources :key, only: [:index]
    end

    namespace :customer do
      resources :worker_record, only: [:show, :update]
    end
  end
end
