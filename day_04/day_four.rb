require_relative "../day_base.rb"

class DayFour < DayBase
  class << self
    def part_one
      compute_score do |sections|
        sections.reverse
      end
    end

    def part_two
      compute_score do |sections|
        sections.map(&:min).reverse
      end
    end

    private

    def compute_score
      input.count do |line|
        sections = line.split(",").map(&to_numeric_range)

        sections
          .zip(yield(sections))
          .any? do |section, other_element|
            section.cover?(other_element)
          end
      end
    end

    def to_numeric_range
      lambda { |str| Range.new(*str.split("-").map(&:to_i)) }
    end
  end
end

puts DayFour.part_one
puts DayFour.part_two
