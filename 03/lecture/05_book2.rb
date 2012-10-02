class BookInStock
  attr_reader :isbn
  attr_accessor :price  
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end

b1 = BookInStock.new("123456789-54", 555)
b2 = BookInStock.new("789451239-20", 123)