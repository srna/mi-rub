code = RubyVM::InstructionSequence.compile('a = 1; puts 1 + a')
puts code.disassemble
code = RubyVM::InstructionSequence.compile('a = 1; puts "a = #{a}."')
puts code.disassemble
#puts RubyVM::INSTRUCTION_NAMES