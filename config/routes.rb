Rails.application.routes.draw do
  get 'introduce/index'
  resources :employees, except: [:show, :destroy]
  resources :attendance_managements, only: [:index, :new, :create]
  get "introduce/index" => "introduce#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
