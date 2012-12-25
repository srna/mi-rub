class Test
    def test
        a = 1
        b = 2
    end
end

set_trace_func lambda {|event, file, line, id, binding, classname|
    printf "%8s %s:%-2d %-15s %-15s\n", event, file, line, classname, id
}
t = Test.new
t.test
