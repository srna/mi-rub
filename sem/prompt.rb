class Prompt
	def initialize(registry, input = STDIN)
    @input = input
    @registry = registry
    do_prompt
    while(line = input.gets)
      if line.strip.length > 0
        exec line.strip
      end
      do_prompt
    end
	end

  private
  def do_prompt
    print "SrnaCalc# " if @input == STDIN
  end
  def exec(line)
    line.strip!
    command_parts = line.split
    command_name = command_parts.shift
    command_args = command_parts
    if (command_name == 'echo') || (command_name == 'eval')
      command_args = line[5..-1]
    end
    if @registry[:commands].has_key? command_name
      @registry[:commands][command_name].run command_args
    else
      @registry[:commands]["echo"].run line
    end
  end
end
