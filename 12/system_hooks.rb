module Kernel
  alias_method :old_system, :system
    def system(*args)
      result = old_system(*args)
      puts "system(#{args.join(', ')}) returned #{result.inspect}"
      result
    end
end
system("date")
system("kangaroo", "-hop 10", "skippy")