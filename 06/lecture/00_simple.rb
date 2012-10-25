

th = Thread.start {
    1+1
}
puts th.value

th = Thread.new {
    sleep(1)
    1+2
}
puts th.value
