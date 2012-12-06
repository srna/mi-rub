#!/usr/bin/env ruby
 
 class Counter
   attr_reader :value
 
   def initialize
     @value = 0
   end
 
   def increment
     @value += 1
   end
 end