#!/usr/bin/env ruby

# GraphSearch
#
#	GraphSearch class accept an input source as an argument (a file, STDIN, etc.) it parses file in format described here: @see http://www.spoj.pl/problems/TDBFS/
#
#	Specification:
#		t [the number of graphs <= 100] 
#	Graph: 
#		n [1 <= n <= 1000 the number of graph vertices] 
#		i m a b c ... [the list of m adjacent vertices to vertex i] 
#	Any query is as follows: [not more than n queries] 
#		v i 
#		where 1 <= v <= n is the beginning vertex and i = 0 for DFS order and i = 1 for BFS order. 
#		0 0 [at the end of the serie] 
#	The list for isolated vertex a is a 0.
#
#	The output of queries is written to standard output (STDOUT)
#
class GraphSearch
  
  def initialize(source)
  end
end