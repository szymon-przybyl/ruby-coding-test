require 'rails_helper'

RSpec.describe RemoveScore, type: :service do
  let!(:leaderboard) { create(:leaderboard) }
  let!(:entry) { create(:leaderboard_entry, leaderboard: leaderboard, score: 0, username: 'Richard') }
  let!(:score) { create(:leaderboard_entry_score, entry: entry, score: 10) }

  it "destroys the requested score" do
    expect {
      described_class.call score: score
    }.to change(LeaderboardEntryScore, :count).by(-1)
  end

  it "decreases score of entry" do
    expect(entry.score).to eq(10)
    described_class.call score: score
    expect(entry.reload.score).to eq(0)
  end

  it 'returns position change' do
    leaderboard.entries.create! username: 'Jane', score: 9
    leaderboard.entries.create! username: 'John', score: 5

    result = described_class.call score: score
    expect(result[:position_change]).to eq (-2)
  end
end
