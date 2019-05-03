Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cats
  resources :rental, only: [:new, :create] do
    member do
      patch "approve"
      patch "deny"
    end
  end
end
