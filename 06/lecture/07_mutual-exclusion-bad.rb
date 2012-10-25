sum = 0
threads = (1..2).collect do
    Thread.new do
        1000000000.times do
             sum += 1
        end
    end
end
threads.each(&:join)
p sum