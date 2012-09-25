def who_says_what(&block)
  block.call("Dave", "hello")
  block.call("Andy", "goodbye")
end
who_says_what {|person, phrase|
  puts "#{person} says #{phrase}"
}