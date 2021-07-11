require 'rails_helper'

RSpec.describe LeaderboardEntryScoresController, type: :controller do

  describe "DELETE #destroy" do
    let!(:leaderboard) { create(:leaderboard) }
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
