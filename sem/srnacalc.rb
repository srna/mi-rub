# SrnaCalc 2013 - Semestralna praca na MI-RUB

require_relative 'prompt'
require_relative 'command'
require_relative 'operator'

class SrnaCalc
  
  def initialize
    @registry = {}
    register_constants
    register_memory
    register_commands
    register_operators
    register_settings
  end

  def run
    if ARGV.length == 0
      banner
      Prompt.new(@registry)
    elsif ARGV.length == 1
      if(File.exists?(ARGV[0]))
        Prompt.new(@registry, File.open(ARGV[0], 'r'))
      else
        puts "Nepodarilo sa otvorit '%s'" % ARGV[0]
      end
    else
      puts "Nespravny pocet argumentov"
    end
  end

  private
  def banner
    puts "SrnaCalc 2.0 (c) 2013 Tomas Srna"
    puts "Tento projekt vznikol ako semestralna praca na predmet MI-RUB."
    puts "Pre zoznam prikazov pouzite prikaz help"
    puts ""
  end
  def register_constants
    @registry[:const] = {}
    @registry[:const]["pi"] = Math::PI
    @registry[:const]["e"] = Math::E
  end
  def register_memory
    @registry[:memory] = {}
  end
  def register_commands
    @registry[:commands] = {}
    [
      ExitCommand.new, 
      EvalCommand.new, 
      EchoCommand.new,
      HelpCommand.new,
      OperatorsCommand.new,
      PrecisionCommand.new,
      MemoryCommand.new,
      ConstCommand.new,
      ReadCommand.new,
      PauseCommand.new,
      CommentCommand.new
    ].each do |c|
      @registry[:commands][c.name] = c
      @registry[:commands][c.name].registry = @registry
    end
    # Pridame aj nejake aliasy
    @registry[:commands]["?"] = @registry[:commands]["help"]
  end
  def register_operators
    @registry[:operators] = {}
    [
      LParOperator.new,
      RParOperator.new,
      UMinusOperator.new,
      PowOperator.new,
      MultiplyOperator.new,
      DivideOperator.new,
      ModuloOperator.new,
      AddOperator.new,
      SubstractOperator.new,
      AssignOperator.new,
      SinOperator.new,
      CosOperator.new,
      TanOperator.new,
      LogOperator.new,
      Log10Operator.new,
      SqrtOperator.new
    ].each do |o|
      @registry[:operators][o.name] = o
      @registry[:operators][o.name].registry = @registry
    end
  end
  def register_settings
    @registry[:settings] = {}
    @registry[:settings]["precision"] = 3
  end
end

sc = SrnaCalc.new
sc.run
