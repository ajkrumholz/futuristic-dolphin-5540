Rails.application.routes.draw do
  get "/mechanics", to: "mechanics#index"
  get "/mechanics/:id", to: "mechanics#show"
  patch "/mechanics/:id", to: "mechanics#update" 

  get "/amusement_parks/:id", to: "amusement_parks#show"
end
