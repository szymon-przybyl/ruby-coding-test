class LeaderboardEntry < ApplicationRecord
  belongs_to :leaderboard
  has_many :scores, class_name: 'LeaderboardEntryScore', dependent: :destroy

  def position
    leaderboard.entries.order(score: :desc).pluck(:id).index(id) + 1
  end
end
