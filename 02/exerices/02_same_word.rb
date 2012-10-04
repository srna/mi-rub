#!/usr/bin/env ruby

def same_word(file)
  res = {}
  file = File.open(file, "r") { |f|
    prev = nil
    f.read_each_line do |line|
      i += 1
      words = line.downcase
                .gsub(/[^a-z ]/,'')
    end
  }

  p res
end
