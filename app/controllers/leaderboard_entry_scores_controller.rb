class LeaderboardEntryScoresController < ApplicationController
  # POST /leaderboard_entry_scores
  def create
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
