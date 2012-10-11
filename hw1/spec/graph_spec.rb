#!/usr/bin/env ruby
$LOAD_PATH << './../'
require_relative '../graph_search'
require 'spec_helper'
require 'benchmark'

describe GraphSearch do
  
  def compare_files(out, expected)
    File.exist?(expected).should be true
    exp = File.open(expected, 'r')
    File.open(out, 'r') do |f|  
      f.each do|line|
        line.should == exp.readline
      end
    end
  end
  
  def run_search(input_file)
    $out_file = "#{File.dirname(__FILE__)}/out.test"
    $stdout = File.new($out_file, 'w')
    
    input = File.open("#{File.dirname(__FILE__)}/input/#{input_file}", 'r')
    GraphSearch.new(input)
    
    $stdout.close
    $stdout = STDOUT
  end
  
  def expected_output(filename)
    "#{File.dirname(__FILE__)}/output/#{filename}"
  end
  it "should search example form http://www.spoj.pl/problems/TDBFS/" do
    file = "g01.txt"
    run_search(file)
    compare_files($out_file, expected_output(file))
  end
  
  it "should search graph with 5 vertices" do
    file = "g05.txt"
    run_search(file)
    compare_files($out_file, expected_output(file))
  end
  
  it "should search graph with 10 vertices" do
    file = "g10.txt"
    run_search(file)
    compare_files($out_file, expected_output(file))
  end

  
  it "should pass benchmark" do
    puts "\n"
    Benchmark.bm do |x|      
      file = "g30.txt"
      x.report("30 nodes") do  
        run_search(file)
      end
      compare_files($out_file, expected_output(file))
      
      
      file = "g50.txt"
      x.report("50 nodes") do  
        run_search(file)
      end
      compare_files($out_file, expected_output(file))
      
      
      file = "g100.txt"
      x.report("100 nodes") do  
        run_search(file)
      end
      compare_files($out_file, expected_output(file))
      
      file = "g200bfs.txt"
      x.report("200 BFS") do  
        run_search(file)
      end
      compare_files($out_file, expected_output(file))
      
      file = "g200dfs.txt"
      x.report("200 DFS") do  
        run_search(file)
      end
      compare_files($out_file, expected_output(file))
      
      file = "g500.txt"
      x.report("500 nodes") do  
        run_search(file)
      end
      compare_files($out_file, expected_output(file))
      
      file = "g1000.txt"
      x.report("1000 nodes") do  
        run_search(file)
      end
      compare_files($out_file, expected_output(file))
      
    end
  end
end