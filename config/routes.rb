Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :tickers, except: [:update, :edit]

  scope :search do
    get :documents, to: 'search#documents'
  end

  root to: 'tickers#index'
end
