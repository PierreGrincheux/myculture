Rails.application.routes.draw do
  namespace :teacher do
  get 'media_file_handlers/index'
  end

  namespace :teacher do
  get 'media_file_handlers/new'
  end

  namespace :teacher do
  get 'media_file_handlers/create'
  end

  namespace :teacher do
  get 'media_file_handlers/destroy'
  end

  get 'media_file_handlers/index'

  get 'media_file_handlers/new'

  get 'media_file_handlers/create'

  get 'media_file_handlers/destroy'

  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'pages#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
     resources :pages do 
				get 'show_current_state', on: :collection
				get 'show_parameters', on: :collection
				get 'show_data', on: :collection
				get 'show_data2', on: :collection
				get 'show_media_file', on: :collection
				patch 'update_parameters', on: :collection
		 end
		
		 resources :tests do
		 end	 

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
    namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
      resources :schools do 
		 	get 'index', on: :collection
		 	post 'create', on: :collection
		  end

		  resources :control_cards do
		  end

		  resources :data_cards do
		  end

		  resources :greenhouses do
		  end
    end

		namespace :teacher do
			resources :supervisions do
			end

			resources :media_file_handlers do
			end
		end




  

end
