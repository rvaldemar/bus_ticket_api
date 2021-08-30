Rails.application.routes.draw do
  apipie
  get 'cities' => 'cities#index'
  get 'search' => 'routes#search'
  post 'buy' => 'ticket#buy'
  put 'buy' => 'ticket#buy'
  post 'cancel/:id' => 'ticket#cancel'
  put 'cancel/:id' => 'ticket#buy'
end
