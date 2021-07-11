class LeaderboardEntryScoresController < ApplicationController
  # POST /leaderboard_entry_scores
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    username = params[:username]
    score = params[:score].to_i

    entry = @leaderboard.entries.find_or_create_by(username: username)
    entry.scores.create(score: score)
    redirect_to @leaderboard, notice: 'Score added'
  end

  # DELETE /leaderboard_entry_scores/1
  def destroy
    @leaderboard_entry_score = LeaderboardEntryScore.find(params[:id])
    @leaderboard_entry_score.destroy
    redirect_to leaderboard_url(@leaderboard_entry_score.entry.leaderboard_id), notice: 'Leaderboard entry score was successfully destroyed.'
  end
end
