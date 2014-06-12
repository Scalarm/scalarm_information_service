ScalarmInformationService::Application.routes.draw do
  # MongoDB instances
  get     'db_instances/list'
  post    'db_instances/register'
  post    'db_instances/deregister'

  post    'db_instances' => 'db_instances#register'
  get     'db_instances' => 'db_instances#list'
  delete  'db_instances' => 'db_instances#deregister'

  # MongoDB config services
  get     'db_config_services/list'
  post    'db_config_services/register'
  post    'db_config_services/deregister'

  post    'db_config_services' => 'db_config_services#register'
  get     'db_config_services' => 'db_config_services#list'
  delete  'db_config_services' => 'db_config_services#deregister'

  # MongoDB routers
  get     'db_routers/list'
  post    'db_routers/register'
  post    'db_routers/deregister'

  post    'db_routers' => 'db_routers#register'
  get     'db_routers' => 'db_routers#list'
  delete  'db_routers' => 'db_routers#deregister'

  get 'storage/list'
  post 'storage/register'
  post 'storage/deregister'

  post 'experiments/register'
  get 'experiments/list'
  post 'experiments/deregister'

  post 'experiment_managers' => 'experiments#register'
  get 'experiment_managers' => 'experiments#list'
  delete 'experiment_managers' => 'experiments#deregister'

  post 'storage_managers' => 'storage#register'
  get 'storage_managers' => 'storage#list'
  delete 'storage_managers' => 'storage#deregister'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
