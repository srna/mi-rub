require "rspec"
require 'spec_helper'
require_relative '../02_same_word'

describe "Same word" do

  it "should find duplicates words in a given file" do
    res = same_word("#{File.dirname(__FILE__)}/words/01.txt")
    res.should be_an_instance_of Hash
    res.size.should == 2
    res.has_key?(1).should be true
    res.has_key?(2).should be true
    res.has_key?(3).should be false
    res.has_value?(["simple"]).should be true
    res.has_value?(["test", "done"]).should be true
  end
  
  it "should find duplicates in the second file" do
    res = same_word("#{File.dirname(__FILE__)}/words/02.txt")
    res.should be_an_instance_of Hash
    res.has_key?(2).should be true
    res.has_key?(3).should be true
    res.has_key?(6).should be true
    res[2].should == ["the"]
  end
  
  it "should ignore interpunction" do
    res = same_word("#{File.dirname(__FILE__)}/words/02.txt")
    res.has_value?(["the"]).should be true
  end
  
  it "should ingore case" do
    res = same_word("#{File.dirname(__FILE__)}/words/02.txt")
    res.has_value?(["this"]).should be true
  end
end