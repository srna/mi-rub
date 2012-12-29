class BSTSet
  def initialize
    @root = nil;
  end
  def << (num)
    if @root.nil?
      @root = Node.new num
    else
      @root.insert num
    end
  end
  def [] (num)
    return -1 if ! @root
    @root.depth num
  end
  def get_count (num)
    return -1 if ! @root
    @root.count num
  end
  def to_s
    output = ""
    each { |e| output += e.to_s + "\n" }
    output + "\n"
  end
  def debug(node = @root)
    out = ""
    if node.data
      out += node.data.to_s
    else
      out += "+(" + debug(node.left) + "," + debug(node.right) + ")"
    end
  end
  def each
    @root.each { |y| yield y } if @root
  end
  include Enumerable
end

# Node je taky "kockopes" - raz uzol okrajovy, raz vnutorny
# Takto nepekne je implementovany preto, lebo nemozeme menit seba sameho
# Keby sme mali pointer-to-pointer, ako je v C, dalo by sa to napisat polymorfne
class Node
  attr_accessor :data, :count
  attr_accessor :left, :right
  def initialize(data, count = 1, left = nil, right = nil)
    @data, @count = data, count
    @left, @right = left, right    
  end
  # Minimum a maximum v podstrome - rozhodovanie kriterium pre najdenie a vlozenie cisla
  # Mozno by stalo zato cachovat tieto hodnoty, takto je to dost pomale
  # Ale som rad, ze to funguje :)
  def min
    @data || left.min
  end
  def max
    @data || right.max
  end
  def insert(data)
    # Vkladame do okrajoveho uzlu
    if @data
      if @data == data || @data.eql?(data)
        @count += 1
      elsif @data < data
        @left, @right = Node.new(@data, @count), Node.new(data)
        @data = nil
      else
        @left, @right = Node.new(data), Node.new(@data, @count)
        @data = nil
      end
    # Vkladame do vnutorneho uzlu - rekurzia
    else
      if data >= @right.min
        @right.insert data
      else
        @left.insert data
      end
    end
  end
  def depth(data, d = 1)
    return d if @data == data || @data.eql?(data)
    return -1 if ! @left && ! @right
    if data > @left.max
      @right.depth(data, d+1)
    else
      @left.depth(data, d+1)
    end
  end
  def count(data)
    return @count if @data == data || @data.eql?(data)
    return -1 if ! @left && ! @right
    if data > @left.max
      @right.count(data)
    else
      @left.count(data)
    end
  end
  def each
    if @data
      yield @data
    else
      @left.each {|y| yield y} if @left
      @right.each {|y| yield y} if @right
    end
  end
end
