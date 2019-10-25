Rails.application.routes.draw do
  get '/astronauts', to: 'astronauts#index'
end
