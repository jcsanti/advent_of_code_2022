require_relative "../day_base.rb"

class DayTwo < DayBase
  class << self
    SCORES = {
      "A" => 1,
      "B" => 2,
      "C" => 3,
    }.freeze

    PAIRS = {
      "A" => "B",
      "B" => "C",
      "C" => "A",
    }.freeze

    def part_one
      compute_score(
        "X" => ->(_) { "A" },
        "Y" => ->(_) { "B" },
        "Z" => ->(_) { "C" },
      )
    end

    def part_two
      compute_score(
        "X" => ->(opponent) { PAIRS.invert[opponent] },
        "Y" => ->(opponent) { opponent },
        "Z" => ->(opponent) { PAIRS[opponent] },
      )
    end

    private

    def compute_score(**xyz_dict)
      input.sum do |line, idx|
        opponent, mine = line.split(/[^\S\n]+/)

        mine = xyz_dict[mine].call(opponent)

        SCORES[mine] + compute_outcome(mine, opponent)
      end
    end

    def compute_outcome(mine, opponent)
      return 3 if draw?(mine, opponent)

      won?(mine, opponent) ? 6 : 0
    end

    def draw?(mine, opponent)
      mine == opponent
    end

    def won?(mine, opponent)
      PAIRS[opponent] == mine
    end
  end
end

puts DayTwo.part_one
puts DayTwo.part_two
