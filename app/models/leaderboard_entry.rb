class LeaderboardEntry < ApplicationRecord
  belongs_to :leaderboard
  has_many :scores, class_name: 'LeaderboardEntryScore'
end
