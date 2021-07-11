require 'rails_helper'

RSpec.describe LeaderboardEntryScoresController, type: :controller do
  let!(:leaderboard) { create(:leaderboard) }

  describe 'POST #create' do
    it 'adds entry' do
      expect {
        post :create, params: { leaderboard_id: leaderboard.id, username: 'lala', score: 1 }
      }.to change(LeaderboardEntry, :count).by(1)
    end

    it 'adds score' do
      expect {
        post :create, params: { leaderboard_id: leaderboard.id, username: 'lala', score: 1 }
      }.to change(LeaderboardEntryScore, :count).by(1)
    end

    it 'increases score of existing leaderboard entry' do
      entry = leaderboard.entries.create! username: 'lala', score: 2

      post :create, params: { leaderboard_id: leaderboard.id, username: 'lala', score: 3 }
      expect(entry.reload.score).to eq 5
    end
  end

  describe "DELETE #destroy" do
    let!(:leaderboard_entry) { create(:leaderboard_entry, leaderboard: leaderboard, score: 100) }
    let!(:leaderboard_entry_score) { create(:leaderboard_entry_score, entry: leaderboard_entry, score: 10) }

    it "destroys the requested leaderboard_entry score" do
      expect {
        delete :destroy, params: { id: leaderboard_entry_score.to_param }
      }.to change(LeaderboardEntryScore, :count).by(-1)
    end

    it "decreases score of entry" do
      delete :destroy, params: { id: leaderboard_entry_score.to_param }
      expect(leaderboard_entry.reload.score).to eq(90)
    end

    it "redirects to the leaderboard" do
      delete :destroy, params: { id: leaderboard_entry.to_param }
      expect(response).to redirect_to(leaderboard_url(leaderboard))
    end
  end
end
