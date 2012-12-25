#!/usr/bin/env ruby

require 'drb'
URI = "drbunix:///tmp/foopie"

class Master
    def initialize(count=100)
        @jobs = []
        count.times do |i|
            @jobs << "Job ##{i}"
        end
    end
    
    def take(n)
      taken = []
      while taken.length < n && !@jobs.empty?
        taken << @jobs.shift
      end
      taken
    end
end

DRb.start_service URI, Master.new

pids = []
10.times do |i|
    pids << fork do
        DRb.start_service
        master = DRbObject.new_with_uri URI
        until (jobs = master.take(2)).empty?
          jobs.each do |j| 
            puts j
            sleep rand
          end
        end
    end
end

puts "started children" 
pids.each { |pid| Process.wait(pid) }