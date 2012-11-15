
cnt1, cnt2 = 0, 0
th1 = Thread.new {
  loop do 
      cnt1 += 1
  end
}
th2 = Thread.new {
  loop do 
      cnt2 += 1
  end
}
print "cnt1 = #{cnt1}, cnt2 = #{cnt2}\n"
th1.priority = 1
th2.priority = 10

sleep(0.1)
th1.kill
th2.kill
print "cnt1 = #{cnt1}, cnt2 = #{cnt2}\n"
