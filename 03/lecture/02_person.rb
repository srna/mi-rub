class Person
  def name
    @name  
  end
  def name=(name)
    @name=name
  end

  def age=(age)
    @age = age
  end

  def age
    @age
  end
end

p = Person.new
p.name = "Mike"
p.age = 18
puts p.to_s
puts "name: #{p.name}, age: #{p.age}"

