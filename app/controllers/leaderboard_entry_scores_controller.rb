class LeaderboardEntryScoresController < ApplicationController
  # POST /leaderboard_entry_scores
  def create
    @leaderboard = Leaderboard.find(params[:leaderboard_id])
    username = params[:username]
    score = params[:score].to_i
    if @leaderboard.entries.where(username: username).exists?
      entry = @leaderboard.entries.where(username: username).first
      entry.increment!(:score, score)
    else
      entry = @leaderboard.entries.create!(username: username, score: score)
    end
    entry.scores.create!(score: score)
    redirect_to @leaderboard, notice: 'Score added'
  end

  # DELETE /leaderboard_entries/1
  def destroy
    @leaderboard_entry_score = LeaderboardEntryScore.find(params[:id])
    entry = @leaderboard_entry_score.entry
    entry.decrement! :score, @leaderboard_entry_score.score
    @leaderboard_entry_score.destroy
    redirect_to leaderboard_url(entry.leaderboard_id), notice: 'Leaderboard entry score was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def leaderboard_entry_score_params
      params.require(:leaderboard_entry_score).permit(:username, :score)
    end
end
