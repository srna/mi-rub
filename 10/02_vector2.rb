 class Vector
   
   def initialize(x , y)
     @x, @y = x, y
   end
   
   def *(value)
     self.class.new(@x * value, @y * value)
   end
   
   def coerce(other)
     return self, other
   end
   
   def to_s
     "[#{@x}, #{@y}]"
   end
 end
 
a = Vector.new(1,2)
puts a * 2
puts 2 * a

puts a.coerce(3)