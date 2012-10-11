#!/usr/bin/env ruby
$LOAD_PATH << './'
require_relative '../06_vowel_finder'
require 'spec_helper'

describe VowelFinder do
   it "should find vowels" do
     vf = VowelFinder.new("the quick brown fox jumped")
     res = [] 
     res = vf.collect {|i| i }
     res.should == ["e", "u", "i", "o", "o", "u", "e"]
   end
   
  it "should have a method `sum`" do
    vf = VowelFinder.new("hello")
    vf.methods.include?(:sum).should be true
  end
  
  it "should perform a sum" do
    vf = VowelFinder.new("The quick brown fox jumps over the lazy dog")
    vf.sum.should == "euioouoeeayo"
  end
  
  it "shoud handle capital letters " do
    vf = VowelFinder.new("A CRARY BIG BUY JUMPS OVER A HORIZONTALLY SIGNIFICANT LADY")
    vf.sum.should == "aayiuyuoeaoioayiiiaay"
  end
  
  it "should include Summable module to Array class" do
    ary = [1, 2, 3]
    ary.methods.include?(:sum).should be true
  end 
  
  it "should include sum over Array class" do
    ary = [1, 2, 3, 4]
    ary.sum.should == 10
  end 
end