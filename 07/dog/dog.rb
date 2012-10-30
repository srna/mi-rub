class DeadError < StandardError; end

class Dog
  def bark
    raise DeadError.new "Can't bark when dead" if @dead
    "woof"
  end

  def die
    @dead = true
  end
end