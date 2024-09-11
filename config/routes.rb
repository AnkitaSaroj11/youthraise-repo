Rails.application.routes.draw do
  get 'payment_customizations/edit'
  namespace :admin do
      resources :users do
        member do
          get 'impersonate'
        end
      end
      resources :supporters
      resources :payments
      resources :organizations
      resources :logins
      resources :delivery_attempts
      resources :campaign_members
      resources :campaigns

      root to: "users#index"
    end
  mount Resque::Server.new, :at => "/resque"
  get 'home/index'
  root "home#index"

  resource :profile, only: [:edit, :update]
  resource :user_session, only: [:destroy]
  resource :user, only: [:edit, :update]
  resources :logins
  resource :payment_customization, only:[:edit, :update]

  resources :organizer_signups do
    member do
      get 'organization'
      patch 'update_organization'
      get 'campaign'
      patch 'update_campaign'
      get 'import'
      patch 'update_import'
      get 'email_confirmation'
      patch 'update_email_confirmation'
      get 'edit_welcome_email'
      patch 'update_welcome_email'
      get 'new_file_import'
      post 'create_file_import'
      get 'trooptrack_import'
      patch 'create_trooptrack_import'
    end
  end
      
  resources :organizations do
    scope module: :organizations do
      resources :members
    end
  end
  resources :campaigns do
    resources :campaign_members, only: [:edit, :update]
    scope module: :campaigns do
      resources :groups
      resource :self_registration
      resources :exports
      resources :messages, only: [:index, :new, :create]
      resources :donor_levels
      resources :members do
        collection do
          post 'add_existing_member'
        end
        member do
          put 'send_activation_email'
        end
      end
      resources :imports
    end
  end

  resource :text_preferences
  resources :campaign_members do
    scope module: :campaign_members do
      member do
        get 'activation'
        patch 'update_activation'
        get 'edit_donation_email'
        patch 'update_donation_email'
        get 'edit_personal_message'
        patch 'update_personal_message'
      end
      resource :dashboard
      resources :donations do
        collection do
          get 'image'
        end
      end
      resources :supporters
      resources :payments do
        member do
          get 'success'
        end
      end
    end
  end
end
