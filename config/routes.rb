# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#             friends_index GET    /friends/index(.:format)                                                                 friends#index
#           friends_destroy GET    /friends/destroy(.:format)                                                               friends#destroy
#           friend_requests GET    /friend_requests(.:format)                                                               friend_requests#index
#                           POST   /friend_requests(.:format)                                                               friend_requests#create
#            friend_request GET    /friend_requests/:id(.:format)                                                           friend_requests#show
#                           PATCH  /friend_requests/:id(.:format)                                                           friend_requests#update
#                           PUT    /friend_requests/:id(.:format)                                                           friend_requests#update
#                           DELETE /friend_requests/:id(.:format)                                                           friend_requests#destroy
#                      root GET    /                                                                                        users#index
#                     users GET    /users(.:format)                                                                         users#index
#                           POST   /users(.:format)                                                                         users#create
#                      user GET    /users/:id(.:format)                                                                     users#show
#                           PATCH  /users/:id(.:format)                                                                     users#update
#                           PUT    /users/:id(.:format)                                                                     users#update
#                           DELETE /users/:id(.:format)                                                                     users#destroy
#        rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
# rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#        rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
# update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#      rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  get 'friends/index'
  get 'friends/destroy'
  resources :friend_requests
  root to: "users#index"
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
