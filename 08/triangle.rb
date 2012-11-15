class Triangle
    SIDES = 3
    def area
        # ..
    end
end

class Square
    SIDES = 4
    
    def initialize(a)
      @a = a
    end
    
    def area
       @a ** 2
    end
end
puts "A triangle has #{Triangle::SIDES} sides"
sq = Square.new(3)
puts "Area of square = #{sq.area}"