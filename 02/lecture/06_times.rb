def gen_times(factor)
  return Proc.new {|n| n*factor }
end

times3 = gen_times(3)      # 'factor' is replaced with 3
times5 = gen_times(5)

p times3.call(12)               #=> 36
p times5.call(5)                #=> 25
p times3.call(times5.call(4))   #=> 60

