=begin
Exercise 1

If we have this code:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

What happens in each of the following cases:

case 1:

hello = Hello.new
hello.hi

puts 'Hello' to the screen

case 2:

hello = Hello.new
hello.bye

NoMethod error, bye not defined in Hello class.

case 3:

hello = Hello.new
hello.greet

InvalidArgument error (0 for 1)

case 4:

hello = Hello.new
hello.greet("Goodbye")

puts 'Goodbye' to the screen

case 5:

Hello.hi

NoMethod error; no .hi for class Hello, just for instances
=end

=begin
Exercise 2

In the last question we had the following classes:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

If we call Hello.hi we get an error message. How would you fix this?

I'd add a class method, defined as self.hi, that put a greeting to the screen.
=end

=begin
Exercise 3

When objects are created they are a separate realization of a
particular class.

Given the class below, how do we create two different instances of
this class, both with separate names and ages?

class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

scratches = AngryCat.new(9, 'Scratches')
hissy = AngryCat.new(11, 'Hissy')
=end

=begin
Exercise 4

Given the class below, if we created a new instance of the class
and then called to_s on that instance we would get something like
"#<Cat:0x007ff39b356d30>".

class Cat
  def initialize(type)
    @type = type
  end
end

How could we go about changing the to_s output on this method
to look like this: "I am a tabby cat" ? (this is assuming that "tabby"
is the type we passed in during initialization).

class Cat
  def initialize(type)
    @type = type
  end
  def to_s
    "I am a #{@type} cat."
  end
end
=end

=begin
Exercise 5

If I have the following class:

class Television
  def self.manufacturer
    # method logic
  end

  def model
    # method logic
  end
end

What would happen if I called the methods like shown below?

tv = Television.new
tv.manufacturer
tv.model

tv.manufacturer would return an undefined method error, b/c there's no instance-
friendly version of the manufacturer method.

Television.manufacturer
Television.model

code would return a value for Television.manufacturer, and then throw a
NoMethod error on Television.model, b/c model isn't a class method.
=end

=begin
Exercise 6

If we have a class such as the one below:

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

In the make_one_year_older method we have used self. What is another
way we could write this method so we don't have to use the self prefix.

def make_one_year_older
  @age += 1
end
=end

=begin
Exercise 7

What is used in this class but doesn't add any value?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a colour of green"
  end

end

The attr_accessor line is not being used at all in this code, since
instance variables are directly modified in the initialize method.
Also, the return statement on the last line.
=end
