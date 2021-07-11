require 'rails_helper'

RSpec.describe LeaderboardEntry, type: :model do
  describe '#position' do
    let!(:leaderboard) { create(:leaderboard) }

    it 'returns current position of entry in leaderboard' do
      richard_entry = create(:leaderboard_entry, leaderboard: leaderboard, username: 'Richard')
      erlich_entry = create(:leaderboard_entry, leaderboard: leaderboard, username: 'Erlich')
      gilfoyle_entry = create(:leaderboard_entry, leaderboard: leaderboard, username: 'Gilfoyle')
      dinesh_entry = create(:leaderboard_entry, leaderboard: leaderboard, username: 'Dinesh')
      jared_entry = create(:leaderboard_entry, leaderboard: leaderboard, username: 'Jared')

      richard_entry.scores.create score: 94
      erlich_entry.scores.create score: 82
      erlich_entry.scores.create score: 13
      gilfoyle_entry.scores.create score: 99
      dinesh_entry.scores.create score: 77

      expect(gilfoyle_entry.position).to eq(1)
      expect(erlich_entry.position).to eq(2)
      expect(richard_entry.position).to eq(3)
      expect(dinesh_entry.position).to eq(4)
      expect(jared_entry.position).to eq(5)
    end
  end
end
