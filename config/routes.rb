Rails.application.routes.draw do

  get 'errors/file_not_found'

  get 'errors/unprocessable'

  get 'errors/internal_server_error'

  get 'errors/access_denied'

  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_for :admins, :controllers => { :admins => "admins" }
  devise_for :secretaries, :controllers => { :secretaries => "secretaries" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get '/sistema' => 'home#sys'
  get '/prof' => 'home#index'
  get '/professors/sign_in/' => 'home#index'  
  get "/users/sign_in/" => "home#index"

  resources :users, except: :edit

  resources :admins do
    collection do
      get :control_panel
      post :duplicate_students
      post :register_undergraduate_courses
      post :register_postgraduate_courses
    end
  end

  resources :advises
  post 'advises/:id/moveup' => 'advises#moveup', as: :moveup_advise
  post 'advises/:id/movedown' => 'advises#movedown', as: :movedown_advise

  resources :request_for_teaching_assistants, except: [:new]
  get 'request_for_teaching_assistants/:semester_id/new' => 'request_for_teaching_assistants#new', as: :new_request_for_teaching_assistant
  get 'request_for_teaching_assistants_for_semester/:semester_id/' => 'request_for_teaching_assistants#index_for_semester', as: :request_for_teaching_assistants_for_semester

  resources :professors
  get 'professors/:id/change_password' => 'professors#change_password', as: :change_professor_password
  post 'professors/:id/make_superprofessor' => 'professors#make_superprofessor', as: :make_super_professor

  resources :courses

  resources :secretaries
  get 'secretaries/:id/change_password' => 'secretaries#change_password', as: :change_secretary_password

  resources :students, except: :show

  #get 'assistant_frequency/' => 'assistant_frequency#index'
  resources :assistant_frequency do
    collection do
      get :index 
      post :request_frequency
    end
  end

  #resources :dumps
  get 'dumps/' => 'dumps#index', as: :dumps

  get 'assistant_frequency/monthly_control/:semester_id/:month/:filter' => 'assistant_frequency#monthly_control', as: :assistant_frequency_monthly_control
  get 'assistant_frequency/monthly_control/:semester_id/:month/:department_id/:filter' => 'assistant_frequency#monthly_control', as: :assistant_frequency_monthly_control_for_department
  post 'assistant_frequency/open_period/:semester_id/:month/:last_filter' => 'assistant_frequency#open_frequency_period', as: :open_frequency_period
  post 'assistant_frequency/close_period/:semester_id/:month/:last_filter' => 'assistant_frequency#close_frequency_period', as: :close_frequency_period
  post 'assistant_frequency/request_frequency/' => 'assistant_frequency#request_frequency', as: :request_frequency
  post 'assistant_frequency/mark_generic_assistant_role_frequency/' => 'assistant_frequency#mark_generic_assistant_role_frequency', as: :mark_generic_assistant_role_frequency
  post 'assistant_frequency/mark_assistant_role_frequency/' => 'assistant_frequency#mark_assistant_role_frequency', as: :mark_assistant_role_frequency
  post 'assistant_frequency/pay_all_assistants/:semester_id/:month' => 'assistant_frequency#pay_all_assistants', as: :pay_all_assistants

  resources :semesters
  post 'semesters/:id/open' => 'semesters#open', as: :open_semester
  post 'semesters/:id/activate' => 'semesters#activate', as: :activate_semester
  post 'semesters/:id/close' => 'semesters#close', as: :close_semester
  post 'semesters/:id/deactivate' => 'semesters#deactivate', as: :deactivate_semester
  post 'semesters/:id/open_evaluation_period' => 'semesters#open_evaluation_period', as: :open_semester_evaluation_period
  post 'semesters/:id/close_evaluation_period' => 'semesters#close_evaluation_period', as: :close_semester_evaluation_period

  resources :candidatures, except: :new
  get 'candidatures/:id/download_transcript' => 'candidatures#download_transcript', as: :download_candidature_transcript
  get 'candidatures/:semester_id/new' => 'candidatures#new', as: :new_candidature
  get 'candidatures/list/:department_id/' => 'candidatures#index', as: :candidatures_with_department
  get 'candidatures/for_department/:semester_id/:department_id/' => 'candidatures#index_for_department', as: :candidatures_for_department
  get 'candidatures/for_student/:student_id/' => 'candidatures#index_for_student', as: :candidatures_for_student


  get 'assistant_roles/' => 'assistant_roles#index', as: :assistant_roles
  get 'assistant_roles/:semester_id' => 'assistant_roles#index', as: :assistant_roles_for_semester
  get 'assistant_roles/for_professor/:professor_id/' => 'assistant_roles#index_for_professor', as: :assistant_roles_for_professor
  get 'assistant_roles/for_professor/:professor_id/:semester_id' => 'assistant_roles#index_for_professor', as: :assistant_roles_for_professor_and_semester
  get 'assistant_roles/certificate/:id' => 'assistant_roles#certificate', as: :certificate
  get 'assistant_roles/report_form/:id' => 'assistant_roles#report_form', as: :report_form
  get 'assistant_roles/print_report/:id' => 'assistant_roles#print_report', as: :print_report
  post 'assistant_roles/notify_for_semester/:semester_id' => 'assistant_roles#notify_for_semester', as: :notify_assistant_roles_for_semester
  post 'assistant_roles/request_evaluations_for_semester/:semester_id' => 'assistant_roles#request_evaluations_for_semester', as: :request_assistant_evaluations_for_semester
  post 'assistant_roles/:request_for_teaching_assistant_id/:student_id/create' => 'assistant_roles#create', as: :create_assistant_role
  post 'assistant_roles/deactivate_assistant_role/:id' => 'assistant_roles#deactivate_assistant_role', as: :deactivate_assistant_role
  patch 'assistant_roles/:id/' => 'assistant_roles#update', as: :update_assistant_role
  delete 'assistant_roles/:id/' => 'assistant_roles#destroy', as: :destroy_assistant_role


  resources :assistant_evaluations, except: [:index, :show, :new, :destroy]
  get 'assistant_evaluations/for_student/:student_id/' => 'assistant_evaluations#index_for_student', as: :assistant_evaluations_for_student
  get 'assistant_evaluations/:assistant_role_id/new' => 'assistant_evaluations#new', as: :new_assistant_evaluation

  get "help_students/:id" => "help_students#index", :as => :help_students

  get "help_professors/:id" => "help_professors#index", :as => :help_professors

  match '/403', to: 'errors#access_denied', via: :all
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  devise_scope :user do
    match '/users/auth/USP/callback', to: 'users/omniauth_callbacks#usp', via: [:get, :post]
  end

  ## External routes
  get '/_instructions' => redirect('http://www.ime.usp.br/grad/monitoria'), as: :official_instructions
  ##################

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
