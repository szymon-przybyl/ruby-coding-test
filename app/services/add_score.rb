# It adds new score and creates entry for new username
# Returns entry and change in entry position (0 for new entry)

class AddScore
  def self.call(*opts)
    self.new(*opts).call
  end

  def initialize(leaderboard:, username:, score:)
    @leaderboard = leaderboard
    @username = username
    @score = score
  end

  def call
    entry = @leaderboard.entries.find_or_initialize_by(username: @username)
    position_before = entry.position

    entry.save if entry.new_record?
    entry.scores.create(score: @score)

    position_change = position_before.nil? ? 0 : position_before - entry.position

    {
      entry: entry,
      position_change: position_change
    }
  end
end