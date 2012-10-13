
module Trig
  PI = 3.141592654
  def Trig.sin(x)
    Math.sin(x)
  end
  def Trig.cos(x)
    Math.cos(x)
  end
end

module Moral
  VERY_BAD = 0
  BAD      = 1
  def Moral.sin(badness)
    case badness
    when VERY_BAD
      return "very bad"
    when BAD
      return "bad"
    else
      return "pretty bad"
    end
  end
end

#require 'trig'
#require 'moral'

y = Trig.sin(Trig::PI/4)
puts "y = #{y}"
wrongdoing = Moral.sin(Moral::VERY_BAD)
puts "wd = #{wrongdoing}"