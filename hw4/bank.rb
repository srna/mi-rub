class Account
  attr_reader :name
  def initialize(name, balance = 0)
    @balance = balance
    @name = name
    @log = []
  end
  def balance
    Money.new(@balance)
  end

  def transfer(money, account)
    
  end

  protected
  def accept(money, account)
    if money.is_a?(Money) && account.is_a?(Account) && money.currency == "CZK"
      @balance += money.value
      @log << "Received [#{money}] #{account.name} -> #{@name}"
    end
  end
end

class Money
  attr_reader :value, :currency
  def initialize(value, currency = "CZK")
    @value = value
    @currency = currency
  end
  def to_s
    "#{@value.round(1)} #{@currency}"
  end
  def - (other)
    if other.is_a? Money
      raise NotSameCurrencyException, 'Not Same Currency' if self.currency != other.currency
      Money.new self.value - other.value, self.currency
    elsif other.is_a? Fixnum
      raise NotSameCurrencyException, 'Fixnum can be added only to CZK'if self.currency != "CZK"
      Money.new self.value - other
    end
  end
  def + (other)
    if other.is_a? Money
      raise NotSameCurrencyException, 'Not Same Currency' if self.currency != other.currency
      Money.new self.value + other.value, self.currency
    elsif other.is_a? Fixnum
      raise NotSameCurrencyException, 'Fixnum can be added only to CZK' if self.currency != "CZK"
      Money.new self.value + other
    end
  end
end

class Fixnum
  def to_money
    Money.new self
  end
end

class NotSameCurrencyException < Exception
end

module CurrencyUtils
  
end
