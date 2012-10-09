class A
  def foo
    "foo"
  end
end

module B
  def bar
    @var = "var B"
    "B bar"
  end
end

module C
  def bar
    @var = "var C"
    "C bar"
  end
end

class D < A
  include B
  include C
  
  def my_var 
    @var
  end
end
d = D.new
puts "D.foo = #{d.foo}"
puts "D.bar = #{d.bar}"
puts d.my_var