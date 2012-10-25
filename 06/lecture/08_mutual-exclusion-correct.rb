sum = 0
mutex = Mutex.new
threads = (1..2).collect do
  Thread.new do
    1_000_000.times do
      mutex.synchronize do
        sum += 1 # do one at a time,
      end        # please   
    end
  end
end
threads.each(&:join)
p sum