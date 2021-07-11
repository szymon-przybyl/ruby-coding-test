class LeaderboardEntryScoresController < ApplicationController
  # POST /leaderboard_entry_scores
  def create
    leaderboard = Leaderboard.find(params[:leaderboard_id])
    username = params[:username]
    score = params[:score].to_i

    @entry = leaderboard.entries.find_or_initialize_by(username: username)
    position_before = @entry.position
    @entry.save if @entry.new_record?
    @entry.scores.create(score: score)

    position_change = position_before.nil? ? 0 : position_before - @entry.position
    redirect_to leaderboard, notice: output_message(position_change)
  end

  # DELETE /leaderboard_entry_scores/1
  def destroy
    leaderboard_entry_score = LeaderboardEntryScore.find(params[:id])
    @entry = leaderboard_entry_score.entry
    position_before = @entry.position

    leaderboard_entry_score.destroy

    position_change = position_before - @entry.position
    redirect_to leaderboard_url(@entry.leaderboard_id), notice: output_message(position_change)
  end

  private

  def output_message(position_change)
    changes = { create: 'added', destroy: 'deleted' }
    msg = "Score #{changes[action_name.to_sym]}"
    if position_change != 0
      msg += ", position of #{@entry.username} #{position_change.positive? ? 'increased' : 'decreased'} by #{position_change.abs}"
    end
    msg
  end
end
