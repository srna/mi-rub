 #!/usr/bin/env ruby
 require 'drb'
 
 counter = DRbObject.new nil, 'druby://:9000'
 
 counter.increment
 puts "The counter value is #{counter.value}"