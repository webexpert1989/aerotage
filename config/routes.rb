Rails.application.routes.draw do
  #devise_for :admins
  root 'static_pages#home'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", registrations:"registrations", sessions:"sessions" }

  devise_scope :user do
    get '/users/sign_out' => 'sessions#destroy' 
    authenticated :user do
      root :to => 'visitors#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'sessions#new', as: :unauthenticated_root
    end
  end

  get 'about-us', to: 'static_pages#about'
  get 'faq', to: 'static_pages#faq'
  get 'aerospace-staffing-solutions-and-services', to: 'static_pages#staffing_solutions'
  get 'aerospace-technical-solutions', to: 'static_pages#technical_solutions'
  get 'aerospace-engineering-solutions', to: 'static_pages#engineering_solutions'
  get 'working-with-us', to: 'static_pages#workingwithus'
  get 'aerotage-overview', to: 'static_pages#overview'
  match 'contact-us', to: 'static_pages#contact', via: [:get, :post]
  get 'privacy-policy', to: 'static_pages#privacy_policy'
  get 'terms-of-use', to: 'static_pages#terms_of_use'
  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  delete :logout, to: 'sessions#destroy'
  get 'my-account', to: 'users#my_account'
  get 'my-credits', to: 'users#my_credits'
  match 'edit-profile', to: 'users#edit_profile', via: [:get, :patch]
  delete 'delete-profile', to: 'users#destroy'
  resources :email_changes, only: [:new, :create, :edit]
    
  namespace :autocomplete do
    get :jobs
    get :resumes
    get 'zip-code'
    get :location
  end

  namespace :locations do
    get 'zip-code-info'
  end
  
  resources :flags, only: [:new, :create]
  
  resources :job_seekers, only: [:new, :create], path_names: { new: :signup } do
    post :create_social, on: :collection
  end
  resources :employers, only: [:new, :create], path_names: { new: :signup } do
    post :create_social, on: :collection
  end
  
  resources :jobs, path: 'job-posting', except: [:index] do
    resources :applications, only: [:new, :create]
    member do
      get :print
      get :my
      get :activate
      get :deactivate
    end
    collection do
      post :search
      match :my, to: :my_listings, via: [ :get, :post ]
    end
  end

  resources :searches, only: [:show, :edit, :update, :destroy] do
    collection do
      get 'saved'
    end
    member do
      get 'undo_criterion'
    end
  end  
  resources :resumes, except: [:index] do
    member do
      get :print
      get :download
      get :my
      get :activate
      get :deactivate
    end

    collection do
      get 'search-form'
      post :search
      match :my, to: :my_listings, via: [ :get, :post ]
    end
  end
  resources :searches, only: [:show, :edit, :update, :destroy] do
    collection do
      get 'saved'
    end
    member do
      get 'undo_criterion'
    end
  end

  resources :saved_jobs, only: [:index] do
    collection do
      get 'add'
      get 'remove'
    end
  end

  resources :saved_resumes, only: [:index] do
    collection do
      get 'add'
      get 'remove'
    end
  end
  match 'applications', to: 'applications#index', via: [:get, :post]
  resources :applications, only: [:show, :destroy] do
    member do
      post :change_status
      post :new_message
    end
  end

  resources :questionnaires, path: 'screening-questionnaires', except: [:show] do
    resources :questionnaire_questions, path: :questions, as: :questions, except: [:show] do
      member do
        get :move_up
        get :move_down
      end
    end
  end
        
  resources :communities, only: [:index, :show] do
    get 'job-posting/:id', to: 'jobs#show', as: :job
  end
  resources :blog_posts, only: [:index, :show], path: 'blog' do
    resources :blog_post_comments, only: [:create, :new], as: :comments, path: 'comments'
  end
  resources :communities

  resources :blog_posts, only: [:index, :show], path: 'blog' do
    resources :blog_post_comments, only: [:create, :new], as: :comments, path: 'comments'
  end

  resources :credits, only: [] do
    collection do
      match :featured_employer, via: [ :get, :post ]
      match :resume_database_access, via: [ :get, :post ]
      match :prolong_listing, via: [ :get, :post ]
      match :featured_listing, via: [ :get, :post ]
      match :priority_listing, via: [ :get, :post ]
      get :buy
      post :purchase
      post :charge
    end
  end

  resources :users

  resources :posts
  get 'jobs-in-:location', to: 'jobs#in_location', as: :jobs_in_location
  get 'jobs-at-:company', to: 'employers#show', as: :employer
  get 'jobs-at-:company/:id', to: 'jobs#show', as: :employer_job
  get 'blog/archive/:year/:month', to: 'blog_posts#index', as: :blog_archive
  get 'blog/community/:community_id', to: 'blog_posts#index', as: :blog_community

  resources :employers do
    member do
      get :activate
      get :deactivate
      get :login
      match :credits, via: [ :get, :post ]
      match :featured, via: [ :get, :post ]
      match :resume_database_access, via: [ :get, :post ]
    end
  end
  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'

    match 'product-settings', to: 'settings#products', via: [ :get, :post ]
    match 'admin-password', to: 'settings#admin_password', via: [ :get, :post ]

    resources :employers do
      member do
        get :activate
        get :deactivate
        get :login
        match :credits, via: [ :get, :post ]
        match :featured, via: [ :get, :post ]
        match :resume_database_access, via: [ :get, :post ]
      end
    end
    resources :job_seekers do
      member do
        get :activate
        get :deactivate
        get :login
        match :credits, via: [ :get, :post ]
      end
    end
    resources :jobs, except: [:new, :create] do
      member do
        match :manage, via: [ :get, :post ]
      end
    end
    resources :resumes, except: [:new, :create] do
      member do
        match :manage, via: [ :get, :post ]
      end
    end

    resources :flags, only: [:index, :destroy]

    resources :communities
    resources :blog_posts, path: 'blog' do
      resources :blog_post_comments, as: :comments, only: [:index], path: 'comments'
    end

    resources :blog_post_comments, except: [:index]

  end

end
