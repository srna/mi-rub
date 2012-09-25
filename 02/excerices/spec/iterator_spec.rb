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

end