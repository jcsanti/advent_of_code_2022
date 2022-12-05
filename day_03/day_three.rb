require_relative "../day_base.rb"

class DayThree < DayBase
  ITEM_TYPE_PRIORITIES =
    (('a'..'z').to_a + ('A'..'Z').to_a)
      .map
      .with_index(1) { |item_type, index| [item_type, index] }
      .to_h
      .freeze

  class << self
    def part_one
      compute_score(input.map(&split_in_half))
    end

    def part_two
      compute_score(input.each_slice(3))
    end

    private

    def compute_score(groups)
      groups.sum do |storage_units|
        ITEM_TYPE_PRIORITIES[find_common_item_type(*storage_units)]
      end
    end

    def find_common_item_type(*storage_units)
      storage_units
        .map { |storage_unit| storage_unit.split("") }
        .inject(&:&)
        .first
    end

    def split_in_half
      lambda do |backpack|
        backpack
          .split("")
          .each_slice(backpack.length / 2)
          .map(&:join)
      end
    end
  end
end

puts DayThree.part_one
puts DayThree.part_two
