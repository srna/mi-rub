class Person
  
  alias :ss :to_s
  
  def to_s
    "my to_s"
  end

  def s
    ss
  end
  
end

a = Person.new
puts "a.to_s: #{a.to_s}"
puts "a.s #{a.s}" 
