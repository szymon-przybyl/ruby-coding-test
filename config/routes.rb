Rails.application.routes.draw do
  resources :leaderboard_entry_scores, only: %i[create destroy]
  resources :leaderboard_entries
  resources :leaderboards do
    post :add_score, on: :member
  end

  root to: 'leaderboards#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
