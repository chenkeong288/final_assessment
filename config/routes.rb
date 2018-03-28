Rails.application.routes.draw do

  root "listings#index"

  #custom route for Search  
  get "/listings/search" => "listings#search"           # Note: Need this 'get' function, or else it will cause an error when refresh. The 'get' function have to be written before the 'listings' route to avoid it clashes with "listings#show" due to same url pattern      
  post "/listings/search" => "listings#search", as: "search"

  resources :users
  resources :sessions

  resources :listings do
     resources :bookings
  end 


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #custom route for Google login
  get "/auth/google_oauth2/callback" => "users#google_oauth2"           #Note: This is default route needed for Google OmniAuth... Need to update Google Api credential 'Authorised redirect URI' to this url

end

