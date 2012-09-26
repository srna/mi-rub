require "rspec"
require 'spec_helper'
require_relative '../03_word_count'


describe "word count" do
  it "should return a Hash with word counts" do
    res = word_count("#{File.dirname(__FILE__)}/words/01.txt")
    res.should be_an_instance_of Hash
    res.size.should == 18
    res.has_key?(:test).should be true
    res[:test].should == 3
    res.has_key?(:simple).should be true
    res[:simple].should == 2
  end
  
  it "should return a Hash with word counts" do
    res = word_count("#{File.dirname(__FILE__)}/words/02.txt")
    res.should be_an_instance_of Hash
    res.has_key?(:there).should be true
    res[:there].should == 2
    res[:the].should == 4
    res[:oh].should eq 3
  end
  
  it "should work with Hamlet monologue" do
    res = word_count("#{File.dirname(__FILE__)}/words/03.txt")
    res.should be_an_instance_of Hash
    res.has_key?(:to).should be true
    res.has_key?(:be).should be true
    res.has_key?(:or).should be true
    res.has_key?(:not).should be true
    res[:to].should eq 15
    res[:be].should eq 4
  end
end

