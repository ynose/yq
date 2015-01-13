Rails.application.routes.draw do
#   get 'dashboard/show'

  resources :users
  resources :paid_vacations
  resources :vacations, :except => [:index, :show]  #index,#showアクションは不要

  root 'dashboard#index'
  get '/dashboard/'                   => 'dashboard#index'
  get '/dashboard/:user_id/:year'     => 'dashboard#show'
  get '/vacations/:id/edit/:callback' => 'vacations#edit'
  get '/vacations/new/:user_id'       => 'vacations#new'
  get '/commute/:user_id/'            => 'commute#index'

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

# == Route Map
#
#             Prefix Verb   URI Pattern                             Controller#Action
#              users GET    /users(.:format)                        users#index
#                    POST   /users(.:format)                        users#create
#           new_user GET    /users/new(.:format)                    users#new
#          edit_user GET    /users/:id/edit(.:format)               users#edit
#               user GET    /users/:id(.:format)                    users#show
#                    PATCH  /users/:id(.:format)                    users#update
#                    PUT    /users/:id(.:format)                    users#update
#                    DELETE /users/:id(.:format)                    users#destroy
#     paid_vacations GET    /paid_vacations(.:format)               paid_vacations#index
#                    POST   /paid_vacations(.:format)               paid_vacations#create
#  new_paid_vacation GET    /paid_vacations/new(.:format)           paid_vacations#new
# edit_paid_vacation GET    /paid_vacations/:id/edit(.:format)      paid_vacations#edit
#      paid_vacation GET    /paid_vacations/:id(.:format)           paid_vacations#show
#                    PATCH  /paid_vacations/:id(.:format)           paid_vacations#update
#                    PUT    /paid_vacations/:id(.:format)           paid_vacations#update
#                    DELETE /paid_vacations/:id(.:format)           paid_vacations#destroy
#          vacations POST   /vacations(.:format)                    vacations#create
#       new_vacation GET    /vacations/new(.:format)                vacations#new
#      edit_vacation GET    /vacations/:id/edit(.:format)           vacations#edit
#           vacation PATCH  /vacations/:id(.:format)                vacations#update
#                    PUT    /vacations/:id(.:format)                vacations#update
#                    DELETE /vacations/:id(.:format)                vacations#destroy
#               root GET    /                                       dashboard#index
#          dashboard GET    /dashboard(.:format)                    dashboard#index
#                    GET    /dashboard/:user_id/:year(.:format)     dashboard#show
#                    GET    /vacations/:id/edit/:callback(.:format) vacations#edit
#                    GET    /vacations/new/:user_id(.:format)       vacations#new
#
