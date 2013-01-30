class Operator
	attr_reader :name, :description, :assoc, :opcount, :precedence
  def registry=(r)
    @registry = r
  end
  def eval(num_stack)
    if num_stack.length < @opcount
      raise "Syntakticka chyba: Nedostatok operandov"
    end
  end
end

class LParOperator < Operator
  def initialize
    @name = "("
    @description = "Lava zatvorka"
    @assoc = :none
    @opcount = 0
    @precedence = 0
  end
end

class RParOperator < Operator
  def initialize
    @name = ")"
    @description = "Prava zatvorka"
    @assoc = :none
    @opcount = 0
    @precedence = 0
  end
end

class UMinusOperator < Operator
  def initialize
    @name = "_"
    @description = "Unarny minus (je mozne pouzit -)"
    @assoc = :right
    @opcount = 1
    @precedence = 10
  end
  def eval(num_stack)
    super
    op = num_stack.pop
    op = op.value if op.is_a? Reference
    num_stack.push -op
  end
end

class PowOperator < Operator
  def initialize
    @name = "^"
    @description = "Mocnina"
    @assoc = :right
    @opcount = 2
    @precedence = 9
  end
  def eval(num_stack)
    super
    result = 1
    op1, op2 = num_stack.pop(2)
    op1 = op1.value if op1.is_a? Reference
    op2 = op2.value if op2.is_a? Reference
    op2.to_i.times { result = result * op1 }
    num_stack.push result
  end
end

class MultiplyOperator < Operator
  def initialize
    @name = "*"
    @description = "Nasobenie"
    @assoc = :left
    @opcount = 2
    @precedence = 8
  end
  def eval(num_stack)
    super
    op1, op2 = num_stack.pop(2)
    op1 = op1.value if op1.is_a? Reference
    op2 = op2.value if op2.is_a? Reference
    num_stack.push op1 * op2
  end
end

class DivideOperator < Operator
  def initialize
    @name = "/"
    @description = "Delenie"
    @assoc = :left
    @opcount = 2
    @precedence = 8
  end
  def eval(num_stack)
    super
    op1, op2 = num_stack.pop(2)
    op1 = op1.value if op1.is_a? Reference
    op2 = op2.value if op2.is_a? Reference
    num_stack.push op1 / op2
  end
end

class ModuloOperator < Operator
  def initialize
    @name = "%"
    @description = "Modulo"
    @assoc = :left
    @opcount = 2
    @precedence = 8
  end
  def eval(num_stack)
    super
    op1, op2 = num_stack.pop(2)
    op1 = op1.value if op1.is_a? Reference
    op2 = op2.value if op2.is_a? Reference
    num_stack.push op1 % op2
  end
end

class AddOperator < Operator
  def initialize
    @name = "+"
    @description = "Pricitanie (funguje aj na retazce)"
    @assoc = :left
    @opcount = 2
    @precedence = 5
  end
  def eval(num_stack)
    super
    op1, op2 = num_stack.pop(2)
    op1 = op1.value if op1.is_a? Reference
    op2 = op2.value if op2.is_a? Reference
    op1 = op1.round(@registry[:settings]["precision"]) if op1.is_a? Float
    op2 = op2.round(@registry[:settings]["precision"]) if op2.is_a? Float
    if (op1.is_a? String) || (op2.is_a? String)
      num_stack.push op1.to_s + op2.to_s
    else
      num_stack.push op1 + op2
    end
  end
end

class SubstractOperator < Operator
  def initialize
    @name = "-"
    @description = "Odcitanie"
    @assoc = :left
    @opcount = 2
    @precedence = 5
  end
  def eval(num_stack)
    super
    op1, op2 = num_stack.pop(2)
    op1 = op1.value if op1.is_a? Reference
    op2 = op2.value if op2.is_a? Reference
    num_stack.push op1 - op2
  end
end

class AssignOperator < Operator
  def initialize
    @name = "="
    @description = "Priradenie"
    @assoc = :right
    @opcount = 2
    @precedence = 3
  end
  def eval(num_stack)
    super
    op1, op2 = num_stack.pop(2)
    if ( ! op1.is_a? Reference) && ( ! op1.is_a? String )
      raise "Lavy operand musi byt premenna"
    end
    if op1.is_a? String
      @registry[:memory][op1] = op2
      ref = Reference.new op1, @registry[:memory]
    else
      @registry[:memory][op1.name] = op2
      ref = op1
    end
    num_stack.push ref
  end
end

class FunctionOperator < Operator
  def initialize
    @assoc = :right
    @opcount = 1
    @precedence = 10
  end
  def eval(num_stack)
    super
    a = num_stack.pop
    a = a.value if a.is_a? Reference
    return a
  end
end

class SinOperator < FunctionOperator
  def initialize
    super
    @name = "sin"
    @description = "Sinus"
  end
  def eval(num_stack)
    num_stack.push Math.sin(super)
  end
end

class CosOperator < FunctionOperator
  def initialize
    super
    @name = "cos"
    @description = "Kosinus"
  end
  def eval(num_stack)
    num_stack.push Math.cos(super)
  end
end

class TanOperator < FunctionOperator
  def initialize
    super
    @name = "tan"
    @description = "Tangens"
  end
  def eval(num_stack)
    num_stack.push Math.tan(super)
  end
end

class LogOperator < FunctionOperator
  def initialize
    super
    @name = "log"
    @description = "Prirodzeny Logaritmus"
  end
  def eval(num_stack)
    num_stack.push Math.log(super)
  end
end

class Log10Operator < FunctionOperator
  def initialize
    super
    @name = "log10"
    @description = "Desiatkovy Logaritmus"
  end
  def eval(num_stack)
    num_stack.push Math.log10(super)
  end
end

class SqrtOperator < FunctionOperator
  def initialize
    super
    @name = "sqrt"
    @description = "Druha odmocnina"
  end
  def eval(num_stack)
    num_stack.push Math.sqrt(super)
  end
end
