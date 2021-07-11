class LeaderboardEntry < ApplicationRecord
  belongs_to :leaderboard
  has_many :scores, class_name: 'LeaderboardEntryScore', dependent: :destroy

  scope :by_score, -> { order(score: :desc) }

  def position
    return if new_record?
    leaderboard.entries.by_score.pluck(:id).index(id)
  end
end
