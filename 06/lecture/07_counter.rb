# Sample code from Programing Ruby, page 134
class Counter
  attr_reader :count
  def initialize
    @count = 0
  end
  def tick
    @count += 1
  end
end

c = Counter.new
threads = (1..3).collect do
  Thread.new do
    1000000000.times {  c.tick }
  end
end
threads.each(&:join)
puts c.count
