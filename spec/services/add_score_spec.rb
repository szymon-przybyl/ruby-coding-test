require 'rails_helper'

RSpec.describe AddScore, type: :service do
  let!(:leaderboard) { create(:leaderboard) }

  it 'adds entry' do
    expect {
      described_class.call leaderboard: leaderboard, username: 'John', score: 10
    }.to change(LeaderboardEntry, :count).by(1)
  end

  it 'adds score' do
    expect {
      described_class.call leaderboard: leaderboard, username: 'John', score: 10
    }.to change(LeaderboardEntryScore, :count).by(1)
  end

  it 'increases score of existing leaderboard entry' do
    entry = leaderboard.entries.create! username: 'John', score: 2

    described_class.call leaderboard: leaderboard, username: 'John', score: 10
    expect(entry.reload.score).to eq 12
  end

  it 'returns position change' do
    leaderboard.entries.create! username: 'John', score: 2
    leaderboard.entries.create! username: 'Jane', score: 3

    result = described_class.call leaderboard: leaderboard, username: 'John', score: 2
    expect(result[:position_change]).to eq(1)
  end
end
