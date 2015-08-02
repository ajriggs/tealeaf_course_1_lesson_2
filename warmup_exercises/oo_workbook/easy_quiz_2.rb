=begin
Exercise 1

You are given the following code:

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

What is the result of calling

oracle = Oracle.new
oracle.predict_the_future

A string will be created (but not stored or printed), that is a concat of
'you will' with a random strings from the array defined as the choices method.
=end

=begin
Exercise 2

We have an Oracle class and a RoadTrip class that inherits from the Oracle
class.

class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  def choices
    ["visit Vegas", "fly to Fiji", "romp in Rome"]
  end
end

What is the result of the following:

trip = RoadTrip.new
trip.predict_the_future

The choices used by .predict_the_future wil be looked up from within the
RoadTrip class, meaining that those new choices will overwrite the choices
inherited from Oracle.
=end

=begin
Exercise 3

How do you find where Ruby will look for a method when that method is
called? How can you find an object's ancestors?

The answer to these is both [object/class].ancestors.

module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

What is the lookup chain for Orange and HotSauce?

Orange/HotSauce
Taste
Object
Kernel
BasicObject
=end

=begin
Exercise 4

What could you add to this class to simplify it and remove two methods from the class definition while still maintaining the same functionality?

class BeesWax
  def initialize(type)
    @type = type
  end

  def type
    @type
  end

  def type=(t)
    @type = t
  end

  def describe_type
    puts "I am a #{@type} of Bees Wax"
  end
end
=end
class BeesWax
  attr_accessor :type

  def initialize(type)
    self.type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

=begin
Exercise 5

There a number of variables listed below. What are the different types and
how do you know which is which?

excited_dog = "excited dog" => local variable; not preceded by any characters.
@excited_dog = "excited dog" => instance variable; denoted by 1 @ preceding name.
@@excited_dog = "excited dog" => class variable; dneoted by 2 @ preceding name.
=end

=begin
Exercise 6

If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

Which one of these is a class method (if any) and how do you know? How would you
call a class method?

self.manufacturer is a class method, as indicated by the self. caller proxy.
It can be called only against its class, e.g. Television.manufacturer.
=end

=begin
Exercise 7

If we have a class such as the one below:

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

Explain what the @@cats_count variable does and how it works. What code would you need
to write to test your theory?

@@cats_count is a class var that stores the amount of instantiated objects of the class
Cat. So, for each time we call a new object of class Cat, @@cats_count increases.

Cat.cats_count
=> 0
tom = Cat.new('tomcat')
Cats.cats_count
=> 1
chesire = Cat.new('chesire')
Cats.cats_count
=> 2
=end

=begin
Exercise 8

If we have this class:

class Game
  def play
    "Start the game!"
  end
end

And another class:

class Bingo
  def rules_of_play
    #rules of play
  end
end

What can we add to the Bingo class to allow it to inherit the play
method from the Game class?

class Bingo < Game
=end

=begin
Exercise 9

If we have this class:

class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

What would happen if we added a play method to the Bingo class, keeping in mind
that there is already a method of this name in the Game class that the Bingo
class inherits from.

The play method defined in the class Bingo would override any instance of the
play method found elsewhere in the method lookup chain.

=begin
Exercise 10

What are the benefits of using Object Oriented Programming in Ruby?
 Think of as many as you can.

 -more forms of control (esp in terms of organization, access, and security)
 -able to produce denser code that is still easy to read w/ practice.
 -allows programmers to repeat themselves even less
 =end
