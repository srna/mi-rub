require 'mutex_m'

sum = 0
threads = (1..2).collect do
    Thread.new do
        1000000000.times do
	     lock
             sum += 1
	     unlock
        end
    end
end
threads.each(&:join)
p sum