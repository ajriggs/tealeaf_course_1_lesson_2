=begin
Exercise 1

Which of the following are objects in Ruby?
If they are objects, how can you find out what class they belong to?

true
"hello"
[1, 2, 3, "happy days"]
142

All of these are objects in ruby. You can identify the class of an object
using the .class method (or the .inspect method, but .class returns it alone).
=end

=begin
Exercise 2

If we have a Car class and a Truck class and we want to be able to go_fast,
how can we add the ability for them to go_fast using the module Speed.
How can you check if your Car or Truck can now go fast?

Author needs to include the module Speed in each desired class.
=end
module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

class Truck
  include Speed
  def go_very_slow
    puts "I am a heavy truck and like going very slow."
  end
end

fit = Car.new
ranger = Truck.new

fit.go_fast
ranger.go_fast

=begin
Exercise 3

String interpolation is being used to call the to_s method on the return value
of self.class, which is [car].class in this case.
 =end

 =begin
 Exercise 4

If we have a class AngryCat how do we create a new instance of this class?
The AngryCat class might look something like this:
=end
 Exercise 4
 class AngryCat
  def hiss
    puts "Hisssss!!!"
  end
end

scratches = AngryCat.new

=begin
Exercise 5

Which of these two classes has an instance variable and how do you know?

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

Class Pizza has an instance var, as denoted by the @ preceding the var name.
=end

=begin
Exercise 6
What could we add to the class below to access the instance variable @volume?

class Cube
 def initialize(volume)
   @volume = volume
 end
end
=end

class Cube
 attr_accessor :volume
 def initialize(volume)
   self.volume = volume
 end
end

# or

class Cube
 def initialize(volume)
   @volume = volume
 end

 def get_volume
   @volume
 end
end

=begin
Exercise 7

What is the default thing that Ruby will print to the screen if you
call to_s on an object? Where could you go to find out if you want
to be sure?

By default, to_s will print the class and encoding of the object iD. To
be sure, I can (and did) check the api-docs for the object method .to_s
=end

=begin
Exercise 8

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

You can see in the make_one_year_older method we have used self. What
does self refer to here?

self is referring to the calling object. So, if we had an object milo,
of the class Cat, with @age = 10, and we called milo.make_one_year_older,
the first line of the method would call milo.age, and add 1 to it.
=end

=begin
Exercise 9

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

In the name of the cats_count method we have used self. What does self
refer to in this context?

Here, self is called within the class block, so it refers to class Cat.
This means to call .cats_count, we will call Cats.cats_count.
=end

=begin
Exercise 10

If we have the class below, what would you need to call to create a new
instance of this class.

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

instantiating any new object of the class Bag requires 2 arguments appended
to Bag.new, the 1st for color, and the 2nd for material.
=end
