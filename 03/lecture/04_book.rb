class BookInStock
  @@count = 0  
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
    @@count += 1 
  end
  def isbn
    @isbn  
  end
  def isbn=(anISBN)
    @isbn=anISBN
  end
  
  def self.count
    @@count
  end
end

b1 = BookInStock.new("123456789-54", 555)
b2 = BookInStock.new("789451239-20", 123)

puts "count = #{BookInStock.count}"