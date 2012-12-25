require "rspec"
require 'spec_helper'
require_relative "../roman.rb"

describe Roman do
  it "should work for small numbers" do
    Roman.new(1).to_s.should == 'i'
    Roman.new(2).to_s.should == 'ii'
    Roman.new(3).to_s.should == 'iii'
    Roman.new(4).to_s.should == 'iv'
    Roman.new(5).to_s.should == 'v'
    Roman.new(6).to_s.should == 'vi'
    Roman.new(7).to_s.should == 'vii'
    Roman.new(8).to_s.should == 'viii'
    Roman.new(9).to_s.should == 'ix'
    Roman.new(10).to_s.should == 'x'
  end
  
  it "should act as an integer" do
    r = Roman.new(1)
    r.respond_to?(:to_int)
    # we should also get method +:to_i+ which comes with +:to_int+
    r.respond_to?(:to_i)
    # default conversion
    r.should == 1
  end
  
  it "should support adding" do
    res = Roman.new(2) + Roman.new(3)
    res.should == 5
    (res.kind_of? Roman).should be true
  end
  
  it "should have defined coerce methods" do
    (2 + Roman.new(3)).should == 5
    (Roman.new(3) + 3).should == 6
  end
  
  it "should support multiplying" do
    (Roman.new(3) * Roman.new(3)).should == 9
    res = 2 * Roman.new(3)
    res.should == 6
    (res.kind_of? Roman).should be true
    (Roman.new(3) * 4).should == 12
  end
  
  it "should be comparable" do 
    (Roman.new(2) > Roman.new(1)).should be true
    (Roman.new(1) < Roman.new(3)).should be true
    (Roman.new(2) == Roman.new(2)).should be true
    (Roman.new(2) != Roman.new(3)).should be true
    (Roman.new(2) <= Roman.new(3)).should be true
    (Roman.new(5) >= Roman.new(3)).should be true
    (Roman.new(5) >= Roman.new(5)).should be true
    (Roman.new(5).between?(Roman.new(2), Roman.new(6))).should be true
  end
  
  it "should compare types and values" do
    Roman.new(2).eql?(Roman.new(2)).should be true
    Roman.new(2).eql?(Roman.new(3)).should be false
    Roman.new(2).eql?(2).should be false
  end
  
  it "should have defined equal? methods" do
    r = Roman.new(5)
    r.equal?(r).should be true
    r.equal?(Roman.new(5)).should be false
  end
  
  it "should be comparable to float" do
    Roman.new(1).should == 1.0
    Roman.new(1).should_not == 1.2
  end
  
  it "should support substraction" do
    (Roman.new(5) - Roman.new(3)).should == 2
    (Roman.new(4) - Roman.new(1)).should == 3
    (Roman.new(4) - 2).should == 2
    res = 6 - Roman.new(1)
    res.should == 5
    (res.kind_of? Roman).should be true
  end
  
  it "should support dividing" do
    res = Roman.new(12) / Roman.new(4)
    res.should == 3
    (res.kind_of? Roman).should be true
    (Roman.new(50) / 10).should == 5
    (16 / Roman.new(4)).should == 4
  end
end