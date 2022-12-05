require_relative "../day_base.rb"

class DayOne < DayBase
  class << self
    def part_one
      calories_sums.max
    end

    def part_two
      calories_sums.sort.last(3).sum
    end

    private

    def calories_sums
      input.each.with_object([0]) do |line, array|
        digit = line.to_i

        if digit == 0
          array << digit
        else
          array[-1] += digit
        end
      end
    end
  end
end

puts DayOne.part_one
puts DayOne.part_two
