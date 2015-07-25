Rails.application.routes.draw do
  resources :photos, except: [:new, :edit]
end
