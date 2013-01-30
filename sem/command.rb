require_relative 'expression'

class Command
  attr_accessor :name, :description
  def registry=(r)
    @registry = r
  end
end

class CommandHelpers
  def self.format(v, precision)
    return v.round(precision) if v.is_a? Float
    return "\"#{v}\"" if v.is_a? String
  end
end

class ExitCommand < Command
  def initialize
    @name = "exit"
    @description = "Ukonci program"
  end

  def run(args)
    abort('Bye')
  end
end

class EvalCommand < Command
  def initialize
    @name = "eval"
    @description = "Vyhodnoti vyraz (bez vypisu vysledku)"
  end

  def run(args)
    begin
      exp = Expression.new args, @registry
=begin
      print "Vyhodnocujem '"
      exp.postfix.each do |p|
        print "op#{p.name} " if p.is_a? Operator
        print "#{p.name}(#{p.value}) " if p.is_a? Reference
        print "#{p} " if (! p.is_a? Operator) && (! p.is_a? Reference)
      end
      puts "' (postfix)"
=end
      return exp.eval
    rescue Exception => e
      puts e
    end
  end
end

class EchoCommand < EvalCommand
  def initialize
    @name = "echo"
    @description = "Vyhodnoti vyraz a vypise vysledok (je mozne 'echo' na zaciatku riadku vynechat)"
  end

  def run(args)
    result = super
    if result.is_a? Float
      puts result.round(@registry[:settings]["precision"])
    elsif result.is_a? Reference
      puts result.value
    else
      puts result
    end
  end
end


class HelpCommand < Command
  def initialize
    @name = "help"
    @description = "Zobrazi napovedu"
  end

  def run(args)
    puts "Zoznam prikazov:"
    @registry[:commands].each_pair do |k,v|
      puts "#{k}\t#{v.description}"
    end
  end
end

class OperatorsCommand < Command
  def initialize
    @name = "operators"
    @description = "Zobrazi operatory"
  end

  def run(args)
    puts "Zoznam operatorov:"
    @registry[:operators].each_pair do |k,v|
      puts "#{k}\t#{v.description}"
    end
  end
end

class PrecisionCommand < Command
  def initialize
    @name = "precision"
    @description = "Zobrazi/nastavi presnost pri vypise cisla"
  end

  def run(args)
    if args.length < 1
      puts "Presnost je nastavena na #{@registry[:settings]["precision"]} desatinnnych miest"
    elsif args.length == 1
      @registry[:settings]["precision"] = Integer(args.first)
    else
      puts "Pouzitie: #{name} [presnost]"
    end
  end
end

class MemoryCommand < Command
  def initialize
    @name = "memory"
    @description = "Zobrazi obsah pamate"
  end

  def run(args)
    puts "Zoznam premennych:"
    @registry[:memory].each_pair do |k,v|
      
      puts "#{k}\t#{CommandHelpers.format v, @registry[:settings]["precision"]}"
    end
  end
end

class ConstCommand < Command
  def initialize
    @name = "const"
    @description = "Zobrazi konstanty"
  end

  def run(args)
    puts "Zoznam konstant:"
    @registry[:const].each_pair do |k,v|
      puts "#{k}\t#{CommandHelpers.format v, @registry[:settings]["precision"]}"
    end
  end
end

class ReadCommand < Command
  def initialize
    @name = "read"
    @description = "Nacita zo vstupu hodnotu do premennej"
  end

  def run(args)
    if args.length != 1
      puts "Pouzitie: #{@name} premenna"
    elsif args.length == 1
      save = STDIN.gets.strip
      begin
        save = Float(save)
      rescue
      end
      @registry[:memory][args.first] = save
    end
  end
end

class PauseCommand < Command
  def initialize
    @name = "pause"
    @description = "Pozastavi aplikaciu po stlacenie ENTER"
  end

  def run(args)
    STDIN.gets
  end
end

class CommentCommand < Command
  def initialize
    @name = "#"
    @description = "Komentar"
  end

  def run(args)
  end
end

