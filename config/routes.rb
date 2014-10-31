Rails.application.routes.draw do

  get 'home/index'

  devise_for :admins, :controllers => { :admins => "admins" }
  devise_for :professors, :controllers => { :professors => "professors" }
  devise_for :secretaries, :controllers => { :secretaries => "secretaries" }
  devise_for :students, :controllers => { :students => "students" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get '/sistema' => 'home#sys'
  get '/prof' => 'home#prof'

  resources :admins do
    collection do
      get :control_panel
      post :duplicate_students
      post :register_undergraduate_courses
      post :register_postgraduate_courses
    end
  end

  resources :request_for_teaching_assistants, except: :new
  get 'request_for_teaching_assistants/:semester_id/new' => 'request_for_teaching_assistants#new', as: :new_request_for_teaching_assistant

  resources :professors
  get 'professors/:id/change_password' => 'professors#change_password', as: :change_professor_password
  post 'professors/:id/make_superprofessor' => 'professors#make_superprofessor', as: :make_super_professor

  resources :courses

  resources :secretaries
  get 'secretaries/:id/change_password' => 'secretaries#change_password', as: :change_secretary_password

  resources :students

  resources :dumps

  resources :semesters
  post 'semesters/:id/open' => 'semesters#open', as: :open_semester
  post 'semesters/:id/close' => 'semesters#close', as: :close_semester

  resources :candidatures, except: :new
  get 'candidatures/:id/download_transcript' => 'candidatures#download_transcript', as: :download_candidature_transcript
  get 'candidatures/:id/new' => 'candidatures#new', as: :new_candidature
  get 'candidatures/list/:department_id/' => 'candidatures#index', as: :candidatures_with_department
  get 'candidatures/for_department/:department_id/' => 'candidatures#index_for_department', as: :candidatures_for_department
  get 'candidatures/for_student/:student_id/' => 'candidatures#index_for_student', as: :candidatures_for_student

  get 'system/candidature_index', as: :system_candidatures

  get 'assistant_roles/' => 'assistant_roles#index', as: :assistant_roles
  post 'assistant_roles/:request_for_teaching_assistant_id/:student_id/create' => 'assistant_roles#create', as: :create_assistant_role
  get 'assistant_roles/update'
  get 'assistant_roles/destroy'

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
