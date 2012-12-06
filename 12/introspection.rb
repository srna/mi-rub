

def hierarchy(obj)
  klass = obj
  begin
      print klass
      klass = klass.superclass
      print " < " if klass
  end while klass
  puts
end

all = {}

count = ObjectSpace.each_object do |x|
    cls = x.class
    unless all.has_key?(cls)
      all[cls] = nil
      hierarchy(cls)
    end
end
puts "Total count: #{count}"