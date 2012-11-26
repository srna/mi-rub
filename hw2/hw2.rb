#!/usr/bin/env ruby
require_relative 'triangles'

# @TODO implement solution 
#   

$D = false

#p Triangles.detect_intersection [[1,3],[4,0]], [[0,0],[3,3]]

if ARGV.length == 0 
  Triangles.new(STDIN)
elsif ARGV.length == 1
  if(File.exists?(ARGV[0]))
    Triangles.new(File.open(ARGV[0], 'r'))
  else
    puts "Can't open file %s" % ARGV[0]
  end
else
  puts "Invalid number of arguments"
  puts "Usage:"
  puts "\tRun without arguments for interactive input"
  puts "\tor"
  puts "\truby #{File.basename(__FILE__)} input_file.txt"
end