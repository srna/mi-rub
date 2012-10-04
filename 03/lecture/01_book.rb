
class BookInStock
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end
end
b1 = BookInStock.new("isbn1", 3)
p b1