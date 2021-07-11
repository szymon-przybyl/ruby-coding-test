class LeaderboardEntryScoresController < ApplicationController
  # POST /leaderboard_entry_scores
  def create
    leaderboard = Leaderboard.find(params[:leaderboard_id])
    add_score = AddScore.call(leaderboard: leaderboard, username: params[:username], score: params[:score].to_i)
    redirect_to leaderboard, notice: output_message(add_score)
  end

  # DELETE /leaderboard_entry_scores/1
  def destroy
    score = LeaderboardEntryScore.find(params[:id])
    remove_score = RemoveScore.call(score: score)
    redirect_to leaderboard_url(remove_score[:entry].leaderboard_id), notice: output_message(remove_score)
  end

  private

  def output_message(entry:, position_change:)
    changes = { create: 'added', destroy: 'deleted' }
    msg = "Score #{changes[action_name.to_sym]}"
    if position_change != 0
      msg += ", position of #{entry.username} #{position_change.positive? ? 'increased' : 'decreased'} by #{position_change.abs}"
    end
    msg
  end
end
