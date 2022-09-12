Rails.application.routes.draw do
  get "/mechanics", to: "mechanics#index"
  get "/mechanics/:id", to: "mechanics#show"
  patch "/mechanics/:id", to: "mechanics#update" 
end
