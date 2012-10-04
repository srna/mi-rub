class Person
  attr_accessor :name, :age

end

p = Person.new
p.name = "Mike"
p.age = 18
puts p.to_s
puts "name: #{p.name}, age: #{p.age}"