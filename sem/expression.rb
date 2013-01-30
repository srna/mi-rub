# Ach... Ruby nema explicitnu referenciu - tak si ju vyrobime
class Reference
  attr_reader :memory, :name
  def initialize(name, memory)
    @name, @memory = name, memory
  end
  def value
    @memory[@name]
  end
end

# Monkey-patch Stringu na zistenie ci je cislo
class String
  def nan?
    self !~ /^\s*[+-]?((\d+_?)*\d+(\.(\d+_?)*\d+)?|\.(\d+_?)*\d+)(\s*|([eE][+-]?(\d+_?)*\d+)\s*)$/
  end
end

class Expression
  attr_reader :expr, :infix, :postfix
	def initialize (expr, registry)
    @expr = expr
    @registry = registry
    @infix = []
    @postfix = []
    tokenize
    shunting_yard
  end

  def eval
    num_stack = []
    @postfix.each do |token|
      if token.is_a? Operator
        token.eval num_stack
      else # operand
        num_stack << token
      end
    end # @postfix.each
    if num_stack.length != 1
      raise "Syntakticka chyba: Privela operandov"
    end
    return num_stack.first
  end

  private
  def tokenize
    inq = false
    token = ""
    p = '\0'
    @expr.each_char do |c|
      next if c == '\r'
      if c == '"'
        inq = !inq
      elsif !is_alnum?(c) && !inq
        if token.length > 0
          @infix << detect(token) # TODO: Detect Token
          token = ""
        end

        # Rozlisenie unarneho minusu - prepis "-" na "_"
        c = '_' if !is_alnum?(p) && p != ')' && c == '-'

        if c != ' ' && c != '\t'
          token << c
        end

        if token.length > 0
          @infix << detect(token) # TODO: Detect Token
          token = ""
        end
      else
        token << c
      end
      if c != ' ' && c != '\t'
        p = c;
      end
    end

    if token.length > 0
      @infix << detect(token) # TODO: Detect Token
      token = ""
    end
  end
  def shunting_yard
    output = []
    op_stack = []
    @infix.each do |token|
      # Pokial mame operand (t.j. nie operator), pridame ho na vystup
      if ! token.is_a? Operator
        output << token
      end

      if token.is_a? Operator
        if token.name == "("
          op_stack.unshift token
        elsif token.name == ")"
          token2 = nil
          while (token2 = op_stack.shift) && (token2.name != "(")
            output << token2
          end
          if token2.nil?
            raise "Syntakticka chyba: Nesparovane zatvorky."
          end
        else # end of elsif token.name == ")"
          op1 = token
          op2 = op_stack.first
          while (!op2.nil?) && 
                (
                  (op1.assoc == :left && op1.precedence <= op2.precedence) ||
                  (op1.assoc == :right && op1.precedence < op2.precedence)
                )
            output << op_stack.shift
            op2 = op_stack.first
          end # while
          op_stack.unshift op1
        end # end of other operator
      end # if token.is_a? Operator
    end # @infix.each do |token|
    while token = op_stack.shift
      if token.name == "(" || token.name == ")"
        raise "Syntakticka chyba: Nesparovane zatvorky."
      else
        output << token
      end
    end # while token = op_stack.shift
    @postfix = output
  end

  def detect(token_str)
    mem = @registry[:memory]
    const = @registry[:const]
    op = @registry[:operators]
    return Reference.new(token_str, mem) if mem.has_key? token_str
    return Reference.new(token_str, const) if const.has_key? token_str
    return op[token_str] if op.has_key? token_str
    return token_str if token_str.nan?
    return token_str.to_f
  end

  def is_alnum?(c)
    return (
        (c.ord >= 'a'.ord && c.ord <= 'z'.ord) ||
        (c.ord >= 'A'.ord && c.ord <= 'Z'.ord) ||
        (c.ord >= '0'.ord && c.ord <= '9'.ord) || c == '.'
      )
  end
end
