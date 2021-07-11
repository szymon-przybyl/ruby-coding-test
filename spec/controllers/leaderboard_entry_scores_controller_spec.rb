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

    it 'sets flash message' do
      post :create, params: { leaderboard_id: leaderboard.id, username: 'lala', score: 1 }
      expect(flash[:notice]).to eq "Score added"
    end

    it 'informs about position change in flash message' do
      leaderboard.entries.create! username: 'John', score: 2
      leaderboard.entries.create! username: 'Jane', score: 3

      post :create, params: { leaderboard_id: leaderboard.id, username: 'John', score: 2 }
      expect(flash[:notice]).to eq "Score added, position of John increased by 1"
    end
  end

  describe "DELETE #destroy" do
    context 'with score' do
      let!(:leaderboard_entry) { create(:leaderboard_entry, leaderboard: leaderboard, score: 0) }
      let!(:leaderboard_entry_score) { create(:leaderboard_entry_score, entry: leaderboard_entry, score: 10) }

      it "destroys the requested leaderboard_entry score" do
        expect {
          delete :destroy, params: { id: leaderboard_entry_score.to_param }
        }.to change(LeaderboardEntryScore, :count).by(-1)
      end

      it "decreases score of entry" do
        expect(leaderboard_entry.score).to eq(10)
        delete :destroy, params: { id: leaderboard_entry_score.to_param }
        expect(leaderboard_entry.reload.score).to eq(0)
      end

      it 'sets flash message' do
        delete :destroy, params: { id: leaderboard_entry.to_param }
        expect(flash[:notice]).to eq "Score deleted"
      end

      it "redirects to the leaderboard" do
        delete :destroy, params: { id: leaderboard_entry.to_param }
        expect(response).to redirect_to(leaderboard_url(leaderboard))
      end
    end

    it 'informs about position change in flash message' do
      entry = leaderboard.entries.create! username: 'John', score: 2
      leaderboard.entries.create! username: 'Jane', score: 3
      score = entry.scores.create! score: 2

      delete :destroy, params: { id: score.to_param }
      expect(flash[:notice]).to eq "Score deleted, position of John decreased by 1"
    end
  end
end
