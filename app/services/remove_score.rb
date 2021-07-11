# It removes score
# Returns entry and change in entry position

class RemoveScore
  def self.call(*opts)
    self.new(*opts).call
  end

  def initialize(score: score)
    @score = score
  end

  def call
    entry = @score.entry
    position_before = entry.position

    @score.destroy

    position_change = position_before - entry.position

    {
      entry: entry,
      position_change: position_change
    }
  end
end
