#!/usr/bin/env ruby
require 'optparse'
op = {}
op[:dict] = "/usr/share/dict/words"

optparse = OptionParser.new do |opts|
  opts.banner = "Usage: anagram [ options ] 
         word..."
  opts.on("-d", "--dict path", String, 
    "Path to dictionary") do |dict|
    op[:dict] = dict
  end
  opts.on("-l", "--load", "Parses dictionary") do
    op[:load] = true
  end
  opts.on("-s", "--solve", "Interactive solver") do
    op[:solve] = true
  end
  opts.on("-h", "--help", "Show this message") do
    puts opts
    exit
  end

end

optparse.parse!(ARGV)

if op.has_key?(:load)
  words = Hash.new([])
  puts "loading dictionary: %s" % op[:dict]
  File.open(op[:dict], "r") do |file|
    while line = file.gets
      word = line.chomp.downcase
      words[word.split('').sort!.join('')] += [word]
    end
  end

  File.open("word_hash", "w") do |file|
    Marshal.dump(words, file)
  end
end

if op.has_key?(:solve)
  words = nil

  File.open("word_hash", "r") do |file|
    words = Marshal.load(file)
  end

  while true
    print "Enter word: "
    anagram = gets.chomp
    sorted_anagram = anagram.split('').sort!.join('')
    p  words[sorted_anagram]
  end
end
