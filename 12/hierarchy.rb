klass = Fixnum
begin
    print klass
    klass = klass.superclass
    print " < " if klass
end while klass
puts
p Fixnum.ancestors