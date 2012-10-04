#!/usr/bin/env ruby

def odd_elements(array)
  res = []
  array.each_with_index do |item, index|
  	if index.odd?
  	  item = yield(item) if block_given?
  	  res << item
  	end
  end
  res
end
