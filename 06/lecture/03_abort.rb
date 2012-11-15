Thread.abort_on_exception = true
t1 = Thread.new do
  puts  "In second thread"
  raise "Raise exception"
end
t1.join
print "not reached\n"