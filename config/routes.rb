Rails.application.routes.draw do


  get 'home/index'

  devise_for :admins, :controllers => { :admins => "admins" }
  devise_for :professors, :controllers => { :professors => "professors" }
  devise_for :secretaries, :controllers => { :secretaries => "secretaries" }
  devise_for :students, :controllers => { :students => "students" }
  devise_for :users, :controllers => { :users => "users" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get '/sistema' => 'home#sys'
  get '/prof' => 'home#prof'
  get '/professors/sign_in/' => 'home#prof'

  resources :users

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

  #resources :dumps
  get 'dumps/' => 'dumps#index', as: :dumps

  resources :semesters
  post 'semesters/:id/open' => 'semesters#open', as: :open_semester
  post 'semesters/:id/activate' => 'semesters#activate', as: :activate_semester
  post 'semesters/:id/close' => 'semesters#close', as: :close_semester
  post 'semesters/:id/deactivate' => 'semesters#deactivate', as: :deactivate_semester

  resources :candidatures, except: :new
  get 'candidatures/:id/download_transcript' => 'candidatures#download_transcript', as: :download_candidature_transcript
  get 'candidatures/:semester_id/new' => 'candidatures#new', as: :new_candidature
  get 'candidatures/list/:department_id/' => 'candidatures#index', as: :candidatures_with_department
  get 'candidatures/for_department/:semester_id/:department_id/' => 'candidatures#index_for_department', as: :candidatures_for_department
  get 'candidatures/for_student/:student_id/' => 'candidatures#index_for_student', as: :candidatures_for_student

  get 'system/candidature_index', as: :system_candidatures

  get 'assistant_roles/' => 'assistant_roles#index', as: :assistant_roles
  get 'assistant_roles/for_professor/:professor_id' => 'assistant_roles#index_for_professor', as: :assistant_roles_for_professor
  post 'assistant_roles/notify_for_semester/:semester_id' => 'assistant_roles#notify_for_semester', as: :notify_assistant_roles_for_semester
  post 'assistant_roles/request_evaluations_for_semester/:semester_id' => 'assistant_roles#request_evaluations_for_semester', as: :request_assistant_evaluations_for_semester
  post 'assistant_roles/:request_for_teaching_assistant_id/:student_id/create' => 'assistant_roles#create', as: :create_assistant_role
  delete 'assistant_roles/:id/' => 'assistant_roles#destroy', as: :destroy_assistant_role

  resources :assistant_evaluations, except: [:index, :show, :new, :destroy]
  get 'assistant_evaluations/for_student/:student_id/' => 'assistant_evaluations#index_for_student', as: :assistant_evaluations_for_student
  get 'assistant_evaluations/:assistant_role_id/new' => 'assistant_evaluations#new', as: :new_assistant_evaluation

  get "help_students/:id" => "help_students#index", :as => :help_students

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
