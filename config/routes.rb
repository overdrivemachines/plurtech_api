# == Route Map
#
#                    Prefix Verb   URI Pattern                                                                              Controller#Action
#                      root GET    /                                                                                        users#index
#      user_friend_requests GET    /users/:user_id/friend_requests(.:format)                                                friend_requests#index
#                           POST   /users/:user_id/friend_requests(.:format)                                                friend_requests#create
#       user_friend_request GET    /users/:user_id/friend_requests/:id(.:format)                                            friend_requests#show
#                           PATCH  /users/:user_id/friend_requests/:id(.:format)                                            friend_requests#update
#                           PUT    /users/:user_id/friend_requests/:id(.:format)                                            friend_requests#update
#                           DELETE /users/:user_id/friend_requests/:id(.:format)                                            friend_requests#destroy
#              user_friends GET    /users/:user_id/friends(.:format)                                                        friends#index
#        user_friends_index GET    /users/:user_id/friends/index(.:format)                                                  friends#index
#      user_friends_destroy GET    /users/:user_id/friends/destroy(.:format)                                                friends#destroy
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
  root to: "users#index"  
  resources :users do
  	resources :friend_requests
  	get "friends", to: "friends#index"  	
  	get "friends/index"
  	get "friends/destroy"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
