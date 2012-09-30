require "rspec"
require 'spec_helper'
require_relative '../01_iterators'

describe "Odd iterator" do

  it "should yield odd elements" do
    res = odd_elements([1,2,3,4,5,6])
    res.should be_an_instance_of Array
    res.should have(3).items
    res.should include(2)
    res.should include(4)
    res.should include(6)
  end

  it "should work different numbers" do
    res = odd_elements([0,1,1,9,2,3])
    res.should be_an_instance_of Array
    res.should have(3).items
    res[0].should == 1
    res[1].should == 9
    res[2].should == 3
  end

  it "should work for float" do
    res = odd_elements([15,4.5,3.14,2.7181,2,0.123])
    res.should be_an_instance_of Array
    res.should have(3).items
    res[0].should == 4.5
    res[1].should == 2.7181
    res[2].should == 0.123
  end

  it "should yield" do
    res = odd_elements([1,2,3,4,5,6]) {|x| x**2 }
    res.should be_an_instance_of Array
    res.should have(3).items
    res[0].should == 4
    res[1].should == 16
    res[2].should == 36
  end
  
  it "should return empty array" do
    res = odd_elements([1]) {|x| puts x}
    res.should be_an_instance_of Array
    res.should have(0).items
    res.should be_empty
  end
  
  it "should not modify original array" do 
    ary = [2,2,2,5,5,8]
    ary2 = ary.dup
    res = odd_elements(ary)
    res[0].should == 2
    res[1].should == 5
    res[2].should == 8
    ary.should == ary2
  end
  
  it "should not modify original array when passing a block" do 
    ary = [2,2,2,5,5,8]
    ary2 = ary.dup
    res = odd_elements(ary) {|x| x+1 }
    ary.should == ary2
  end
  
end