FactoryBot.define do
  factory :leaderboard_entry do
    username { 'John' }
    score { 0 }
    leaderboard
  end
end
