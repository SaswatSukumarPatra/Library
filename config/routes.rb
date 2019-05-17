Rails.application.routes.draw do
  resources :book
  resources :e_users, only: [:create, :index] do
    resources :expenses, only: [:create, :index]
    resources :user_expenses, only: [:index, :settle]
    put '/user_expenses/:id/settle', to: 'user_expenses#settle'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
