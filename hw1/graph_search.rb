#!/usr/bin/env ruby

# GraphSearch
#
#  GraphSearch class accept an input source as an argument (a file, STDIN, etc.) it parses file in format described here: @see http://www.spoj.pl/problems/TDBFS/
#
#  Specification:
#    t [the number of graphs <= 100] 
#  Graph: 
#    n [1 <= n <= 1000 the number of graph vertices] 
#    i m a b c ... [the list of m adjacent vertices to vertex i] 
#  Any query is as follows: [not more than n queries] 
#    v i 
#    where 1 <= v <= n is the beginning vertex and i = 0 for DFS order and i = 1 for BFS order. 
#    0 0 [at the end of the serie] 
#  The list for isolated vertex a is a 0.
#
#  The output of queries is written to standard output (STDOUT)
#

$D = false

require 'thread'

class GraphSearch
  def initialize(source)
    @source = source
    @nodes = []
    @graph_count = 0
    @graph_cur = 0
    begin
      while @graph_cur <= @graph_count && ! @source.eof? do
        read
      end
    rescue
      puts "Error: #{$!}"
    end
  end
  # Nacitanie dalsieho riadku
  def read
    line = @source.gets.split.collect! {|i| i.to_i}
    puts "#>#{line}" if $D
    
    # Jedna sa o zaciatok, najprv nacitame 
    if @graph_cur == 0 || @graph_count == 0
      @graph_count = line.first
      if @graph_count < 1 || @graph_count > 1000
        raise "Graph count out of range"
      end
      puts "# Graph count set to #{@graph_count}" if $D
      graph_next
      return
    end
    
    # Dalsie riadky musia uz obsahovat aspon 2 prvky
    if line.size < 2
      puts "# Ignoring invalid line" if $D
      return
    end

    # Rozhodneme, ci sa jedna o 
    #   - koniec grafu [0,0]
    #   - query [v,i], kde v musi existovat
    #   - zadanie adjacency [i,m,a,b,c]
    if line == [0,0]
      puts "# End of graph #{@graph_cur}" if $D
      graph_next
    elsif ! @nodes[line.first].nil?
      puts "# Query" if $D
      if line.last == 0 
        puts "# Doing DFS" if $D
        dfs line.first
        puts
      else
        puts "# Doing BFS" if $D
        bfs line.first
        puts
      end
    else
      i = line.shift
      m = line.shift
      puts "# Adding adjacency #{i}(#{m}): #{line}" if $D
      @nodes[i] = line
    end
  end
  # Dalsi graf
  def graph_next
    @graph_cur += 1
    @nodes.clear
    puts "# Moving to next graph #{@graph_cur}" if $D
    puts "graph #{@graph_cur}" if @graph_cur <= @graph_count
  end

  def dfs(v, s = Hash.new(:unexplored), f = true)
    s[v] = :explored
    print "#{v}" if f
    print " #{v}" unless f
    f = false
    @nodes[v].each do |n|
      dfs n, s, f if s[n] == :unexplored
    end
  end

  def bfs(v, f = true)
    q = Queue.new
    q.push v
    s = Hash.new(:unmarked)
    s[v] = :marked
    while ! q.empty?
      t = q.pop
      print "#{t}" if f
      print " #{t}" unless f
      f = false
      @nodes[t].each do |n|
        if s[n] == :unmarked
          s[n] = :marked
          q.push n
        end
      end
    end
  end
end

# GraphSearch.new File.open("spec/input/g01.txt", "r")

