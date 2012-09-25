
x = Proc.new {|x| print "number #{x}"}
x.call(5)

puts "\n methods"
x = Proc.new {|x| print "number #{x}"}
puts x.methods

