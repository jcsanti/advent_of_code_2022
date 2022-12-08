class DayBase
  INPUT_FILENAME = "input.txt".freeze

  class << self
    def part_one
      raise NotImplementedError
    end

    def part_two
      raise NotImplementedError
    end

    private

    def input(filename = INPUT_FILENAME)
      IO.readlines(filepath(filename), chomp: true)
    end

    def each_char(filename = INPUT_FILENAME)
      File.open(filepath(filename)) do |file|
        file.each_char.lazy.each do |char|
          yield(char)
        end
      end
    end

    def filepath(filename)
      File.expand_path(filename, File.dirname(caller_locations[1].path))
    end
  end
end
