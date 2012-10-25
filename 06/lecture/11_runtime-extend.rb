require 'monitor'
class Counter
  attr_reader :count
  def initialize; @count = 0; super; end
  def tick; @count += 1; end
end
c = Counter.new
c.extend(MonitorMixin)
t1 = Thread.new { 10000.times do  
     c.synchronize { c.tick } 
end }
t2 = Thread.new { 10000.times do 
    c.synchronize { c.tick } end }
t1.join; t2.join 
puts c.count