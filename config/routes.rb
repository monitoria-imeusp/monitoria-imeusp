Rails.application.routes.draw do

  get 'home/index'
  get 'home/dump'

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


  resources :admins

  resources :request_for_teaching_assistants
  resources :professors
  get 'professors/:id/change_password' => 'professors#change_password', as: :change_professor_password

  resources :courses
  resources :secretaries
  get 'secretaries/:id/change_password' => 'secretaries#change_password', as: :change_secretary_password

  resources :students
  resources :request_for_teaching_assistants

  resources :candidatures

  resources :candidatures do
      get :download
  end

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
