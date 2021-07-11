class LeaderboardEntryScore < ApplicationRecord
  belongs_to :entry, class_name: 'LeaderboardEntry', foreign_key: 'leaderboard_entry_id'

  after_create :increment_entry_score
  after_destroy :decrement_entry_score

  private

  def increment_entry_score
    entry.increment! :score, score
  end

  def decrement_entry_score
    entry.decrement! :score, score
  end
end
