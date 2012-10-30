require 'rspec'
$:.unshift File.join(File.dirname(__FILE__),'..')
require 'dog'

describe Dog do
  before(:all) do
    @dog = Dog.new
  end

  context "when alive" do
    it "barks" do
      @dog.bark.should == "woof"
    end
  end

  context "when dead" do
    before do
      @dog.die
    end

    it "raises an error when asked to bark" do
      lambda { @dog.bark }.should raise_error(DeadError)
    end
  end
end