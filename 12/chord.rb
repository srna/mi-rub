class Note < Struct.new(:value)
    def to_s
        value.to_s
    end
end

class Chord
    def initialize(arr)
        @arr = arr
    end
    def play
        @arr.join('')
    end
end