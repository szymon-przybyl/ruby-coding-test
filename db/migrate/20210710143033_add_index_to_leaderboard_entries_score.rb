class AddIndexToLeaderboardEntriesScore < ActiveRecord::Migration[5.1]
  def change
    add_index :leaderboard_entries, [:leaderboard_id, :score], order: { score: :desc }
  end
end
