require 'rails_helper'

RSpec.describe LeaderboardEntryScore, type: :model do
  let!(:leaderboard_entry) { create(:leaderboard_entry, score: 50) }

  it 'updates entry score upon creation' do
    leaderboard_entry.scores.create score: 10
    expect(leaderboard_entry.reload.score).to eq 60
  end

  it 'updates entry score upon deletion' do
    entry = leaderboard_entry.scores.create score: 10
    entry.destroy
    expect(leaderboard_entry.reload.score).to eq 50
  end
end
