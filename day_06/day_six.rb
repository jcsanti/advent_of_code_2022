require_relative "../day_base.rb"

class DaySix < DayBase
  class << self
    def part_one
      processed_character_count(4)
    end

    def part_two
      processed_character_count(14)
    end

    private

    def processed_character_count(marker_length)
      array = []

      each_char do |char|
        array << char

        next unless contains_marker?(array, marker_length)

        break array.length
      end
    end

    def contains_marker?(array, marker_length)
      array.last(marker_length).uniq.length == marker_length
    end
  end
end

puts DaySix.part_one
puts DaySix.part_two
