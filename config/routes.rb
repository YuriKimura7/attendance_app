Rails.application.routes.draw do
  resources :employees, except: [:show, :destroy]
  resources :attendance_managements, only: [:index, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
