require_relative "../day_base.rb"

class DayFive < DayBase
  class << self
    def part_one
      compute_score(in_batches: false)
    end

    def part_two
      compute_score(in_batches: true)
    end

    private

    def compute_score(in_batches:)
      compute_hash(in_batches)
        .sort
        .map(&:last.to_proc >> :last.to_proc)
        .join("")
    end

    def compute_hash(in_batches)
      input.each.with_object({}) do |line, hash|
        if move_directive?(line)
          move(in_batches, hash, *extract_move_directives(line))
        else
          add_to_columns(split_to_cells(line), hash)
        end
      end
    end

    def move_directive?(line)
      line.match?(/^[^\S\n]*move\s/)
    end

    def extract_move_directives(line)
      line.scan(/\d+/).map(&:to_i)
    end

    def move(in_batches, hash, count, origin, destination)
      counters = [count, 1]
      counters.reverse! if in_batches
      count, pop = counters

      count.times do
        hash[origin].pop(pop).each do |letter|
          hash[destination] << letter
        end
      end
    end

    def add_to_columns(cells, hash)
      cells.each.with_index(1) do |cell, index|
        letter = extract_letter(cell)

        next unless letter

        hash[index] ||= []
        hash[index].unshift(letter)
      end
    end

    def split_to_cells(line)
      line.split("").each_slice(4)
    end

    def extract_letter(cell)
      cell.detect { |element| element.match?(/[A-Z]/) }
    end
  end
end

puts DayFive.part_one
puts DayFive.part_two
