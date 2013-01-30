require 'spec_helper'
require_relative '../bank'

# Podla zadania https://edux.fit.cvut.cz/courses/MI-RUB/homeworks/12/start

describe Account do
  # 1. založení účtu
  it "can be created" do
    a = Account.new "Tomas Srna"
  end
  # 2. zjištění zůstatku účtu
  it "can show the balance" do
    a = Account.new "Vito Corleone", 1000000000
    a.balance.to_s.should == "1000000000.0 CZK"
  end
  # 3. převod peněz mezi účty
  it "can transfer money" do 
    a1 = Account.new "A1", 500
    a2 = Account.new "A2", 200
    a1.transfer a2, 50
    a1.balance.to_s.should == 450
    a2.balance.to_s.should == 250
  end
  # 4. výpis všech transakcí na účtu
  it "can list transactions" do
    pending
  end
end

describe Money do
  # 5. převod částky do jiné měny
  it "can be converted to other currency" do
    pending
  end
  # Dále je nezbytné implementovat třídu Money, která bude sloužit pro uchování množství peněz a bude zaručovat přesnost výpočtů (tj. nechceme, aby se ztrácely peníze díky chybě v zaokrouhlení).
  it "can not lose precision in +/- operation" do
    m1 = Money.new 10
    m2 = Money.new 0.05
    m3 = m1 - m2
    m3.to_s.should == "10.0 CZK"
  end
  # Výchozí měnou jsou české koruny
  it "can be converted to string with default currency" do
    m = Money.new 1234.5678
    m.to_s.should be == '1234.6 CZK'
  end
  it "can be operated +/-" do
    m1 = Money.new 500, "EUR"
    m2 = Money.new 300, "EUR"
    m = m1 + m2
    m.to_s.should be == '800.0 EUR'
  end
  it "can +/- with Fixnum" do
    m1 = Money.new 500
    m = m1 + 500
    m.to_s.should be == '1000.0 CZK'
  end
  it "can compare to other Money" do
    pending
  end
  it "is converted to CZK when adding different currencies" do 
    pending
  end
end

describe Fixnum do
  it "can be converted to Money" do
    m = 500.to_money
    m.to_s.should be == "500.0 CZK"
  end
end

describe String do
  it "can be converted to Money" do
    pending
  end
end