class Leaderboard < ApplicationRecord
  has_many :entries, class_name: 'LeaderboardEntry'
  has_many :scores, through: :entries
end
