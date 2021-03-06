# == Route Map
#
#                        Prefix Verb   URI Pattern                                                                              Controller#Action
#                          root GET    /                                                                                        users#index
# user_friend_requests_incoming GET    /users/:user_id/friend_requests/incoming(.:format)                                       friend_requests#incoming
# user_friend_requests_outgoing GET    /users/:user_id/friend_requests/outgoing(.:format)                                       friend_requests#outgoing
#          user_friend_requests GET    /users/:user_id/friend_requests(.:format)                                                friend_requests#index
#                               POST   /users/:user_id/friend_requests(.:format)                                                friend_requests#create
#           user_friend_request PATCH  /users/:user_id/friend_requests/:id(.:format)                                            friend_requests#update
#                               PUT    /users/:user_id/friend_requests/:id(.:format)                                            friend_requests#update
#                               DELETE /users/:user_id/friend_requests/:id(.:format)                                            friend_requests#destroy
#                  user_friends GET    /users/:user_id/friends(.:format)                                                        friends#index
#                               POST   /users/:user_id/friends(.:format)                                                        friends#create
#                   user_friend DELETE /users/:user_id/friends/:id(.:format)                                                    friends#destroy
#                    user_posts GET    /users/:user_id/posts(.:format)                                                          posts#index
#                               POST   /users/:user_id/posts(.:format)                                                          posts#create
#                          post GET    /posts/:id(.:format)                                                                     posts#show
#                               PATCH  /posts/:id(.:format)                                                                     posts#update
#                               PUT    /posts/:id(.:format)                                                                     posts#update
#                               DELETE /posts/:id(.:format)                                                                     posts#destroy
#                     user_feed GET    /users/:user_id/feed(.:format)                                                           users#feed
#                         users GET    /users(.:format)                                                                         users#index
#                               POST   /users(.:format)                                                                         users#create
#                          user GET    /users/:id(.:format)                                                                     users#show
#                               PATCH  /users/:id(.:format)                                                                     users#update
#                               PUT    /users/:id(.:format)                                                                     users#update
#                               DELETE /users/:id(.:format)                                                                     users#destroy
#            rails_service_blob GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#     rails_blob_representation GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#            rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#     update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#          rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  
  root to: "users#index"
  resources :users do
  	get "friend_requests/incoming", to: "friend_requests#incoming"
  	get "friend_requests/outgoing", to: "friend_requests#outgoing"
    resources :friend_requests, except: [:show]
  	
  	# index create new show update destroy actions available
    resources :friends, only: [:index, :create, :destroy]

    resources :posts, shallow: true

    get 'feed'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
