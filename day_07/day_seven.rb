require_relative "../day_base.rb"

class DaySeven < DayBase
  TOTAL_AVAILABLE = 70_000_000
  REQUIRED = 30_000_000

  class StatFS
    def initialize
      @pwd = ""
      @dir_sizes = {}
    end

    attr_accessor :pwd
    attr_reader :dir_sizes
  end

  module Matchers
    SPACES = /\s+/
    SIZE = /^\d+$/
    ANY_DIR = /[^\/]*\/$/
    DIR_EXCEPT_ROOT = /[^\/]+\/$/
  end

  class << self
    def part_one
      dir_sizes(statfs).sum { |_dir, size| size <= 100_000 ? size : 0 }
    end

    def part_two
      result = dir_sizes(statfs)

      root_dir_size = result["/"]
      unused_space = TOTAL_AVAILABLE - root_dir_size

      target = REQUIRED - unused_space

      result.filter_map { |_dir, size| next size if size >= target }.min
    end

    private

    def statfs
      StatFS.new
    end

    def dir_sizes(statfs)
      input.each do |line|
        dollar_or_size, command_or_filename, arg = line.split(Matchers::SPACES)

        if dollar_or_size.match?(Matchers::SIZE)
          increment_dir_sizes(statfs, dollar_or_size)
        else
          exec_cmd(statfs, command_or_filename, arg)
        end
      end

      statfs.dir_sizes
    end

    def increment_dir_sizes(statfs, size)
      pwd = statfs.pwd.dup

      while pwd.length > 0
        statfs.dir_sizes[pwd] ||= 0
        statfs.dir_sizes[pwd] += size.to_i
        pwd.sub!(Matchers::ANY_DIR, "")
      end
    end

    def exec_cmd(statfs, command, arg)
      return unless command == "cd"

      case arg
      when "/" then statfs.pwd = "/"
      when ".." then statfs.pwd.sub!(Matchers::DIR_EXCEPT_ROOT, "")
      when /\w+/ then statfs.pwd += "#{arg}/"
      end
    end
  end
end

puts DaySeven.part_one
puts DaySeven.part_two
