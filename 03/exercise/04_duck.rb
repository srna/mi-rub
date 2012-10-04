#!/usr/bin/env ruby

class Duck
    
  attr_accessor :name

  @@num_quacks = 0

  def quack 
  	@num_quacks = @num_quacks + 2
  	@@num_quacks = @@num_quacks + 2
  	"quack quack"
  end

  def self.can_fly
  	true
  end

  def swimming=(swimming)
  	@swimming = swimming
  	@flying = false if @swimming
  end

  def flying=(flying)
  	@flying = flying
  	@swimming = false if @flying
  end

  def is_swimming
  	@swimming
  end

  def is_flying
  	@flying
  end

  def num_quacks
  	@num_quacks
  end

  def self.num_quacks
  	@@num_quacks
  end

  def initialize(name, age)
  	@name, @age = name, age
  	@num_quacks = 0
  end

  def compare(duck)
  	if @age < duck.age
      -1
    elsif @age > duck.age
      1
    else
      0
    end
  end

protected
  def age
  	@age
  end

end