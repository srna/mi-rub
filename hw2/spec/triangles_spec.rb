#!/usr/bin/env ruby
$:.unshift File.dirname(__FILE__)
require 'spec_helper'
require 'open3'

describe 'TrianglesSolver' do
  
  before(:all) do
    @program = "#{File.dirname(__FILE__)}/../hw2.rb"
    @out_dir = "#{File.dirname(__FILE__)}/outputs"
    @test_in1 = "#{File.dirname(__FILE__)}/inputs/test1"
    @test_in2 = "#{File.dirname(__FILE__)}/inputs/test2"
    @test_in3 = "#{File.dirname(__FILE__)}/inputs/test3"
    @suite = [@test_in1, @test_in2, @test_in3]
    @score = Hash.new(0)
    @points = [5, 8, 7]
  end
  
  # goes through all files in given directory
  def each_file(dir)
     Dir.foreach(dir) do |item|
       next if item == '.' or item == '..'
       yield(item)
     end
  end
    
  it "should have test directories" do
    @suite.each do |test|
      File.directory?(test).should be true
    end
  end
  
  it "should have reference solution" do
    @suite.each do |test|
      each_file(test) do |item|
	 File.exist?("#{@out_dir}/#{item}ref.txt")
      end
    end
  end
  
  def compare(line, got, num, item)
    if(line != got) then
      puts "\nTest #{num+1}, item: #{item}:\n Expected: #{line}\n but got: #{got}"
      @points[num] -=1 if @points[num] > 0
    else
      @score[num] += 1
    end
  end
  
  it "should pass all test suites" do
    num = 0
    @suite.each do |test|
      i = 0
      each_file(test) do |item|
	cmd =  "ruby #{@program} < #{test}/#{item}"
	expected = "#{@out_dir}/#{item}ref.txt"
	Open3.popen3(cmd) do |stdin, stdout, stderr, wait_thrs|
	    File.open(expected, 'r') do |f|  
	      f.each do|line|
		  @points[num] = 0 if stdout.eof?
		  got = stdout.readline
		  compare(line, got, num, item)
	      end
	    end
	  unless stderr.eof?
	    puts stderr.readlines
	    raise 'strderr should be empty'
	  end
	end
	i +=1
      end
      @score[num] = (100 * @score[num]) /i
      num += 1
    end
  end
  
  it "should have full score" do
    for i in 0..2 do
      @score[i].should eq 100
    end
  end 
  
  after(:all) do
    print "\nVysledky testovani:\n"
    sum = 0.0
    for i in 0..2 do
      res =  @score[i]* @points[i] / 100
      sum += res
      puts "\tTestovaci sada #{i+1}: %d%%, bodu: %d" % [@score[i], res]
    end
    print "\n\t*************************************\n"
    print   "\t* Celkovy pocet ziskanych bodu: %d  *\n" % sum
    print "\t*************************************\n"
  end
 
end