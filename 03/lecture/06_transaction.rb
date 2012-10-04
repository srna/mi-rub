class Account
  attr_accessor :balance
  
  def initialize
    @balance = 0
  end
  
  def to_s
    return "#<Account, balance= #{balance}>"
  end
end


class Transaction
  def initialize(account_a, account_b)
    @account_a = account_a
    @account_b = account_b
  end
  def debit(account, amount)
    account.balance -= amount
  end
  def credit(account, amount)
    account.balance += amount
  end
  def transfer(amount)
    self.debit(@account_a, amount)
    self.credit(@account_b, amount)
  end
   
  def to_s
    return "#<Transaction, a= #{@account_a}, b= #{@account_b}>"
  end
end
tr = Transaction.new(Account.new, Account.new)
tr.transfer(20)

puts tr