require 'test/unit'
$:.unshift File.join(File.dirname(__FILE__),'..')
require 'dog'

  class DogTest < Test::Unit::TestCase
    def setup
      @dog = Dog.new
    end

    def test_barks
      assert_equal "woof", @dog.bark    
    end

    def test_doesnt_bark_when_dead
      @dog.die
      assert_raises DeadError do
        @dog.bark
      end
    end
  end