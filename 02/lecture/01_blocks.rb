[1, 2, 3].each {|x| print "#{x}!\n" }

[1, 2, 3].each_with_index {|item, index|
  print "#{item} at #{index}!\n"
}
