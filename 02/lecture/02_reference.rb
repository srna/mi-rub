
puts "Number"
puts "======="
a = 13
b = a
puts "a = #{a}, b = #{b}"
a = 7
puts "a = #{a}, b = #{b}"


puts "String"
puts "======="

a = "Lorem ipsum"
b = a

puts "a = #{a}, b = #{b}"
# string is by default mutable
a.upcase!
puts "a = #{a}, b = #{b}"

puts "Immutable string"
puts "======="

a = "Lorem ipsum"
a.freeze
b = a

puts "a = #{a}, b = #{b}"
# will cause TypeError
a.upcase!
puts "a = #{a}, b = #{b}"
