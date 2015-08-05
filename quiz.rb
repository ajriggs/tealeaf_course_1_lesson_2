# Question 1
# a = 1 # => this is a local variable, a Fixnum object w/ value 1
# @a = 2 # => example of an instance variable, a Fixnum object w/ value 2
# user = User.new # => new instance/object of the class User
# user.name # => calling a getter to return the name instance var of user
# user.name = 'Joe' # => calling a setter to assign the string 'Joe' to the name var

# Question 2
# How does a class mixin a module?
# using the keyword 'include', followed by a space and the name of the module.

# Question 3
# What's the difference between class variables and instance variables?
# A class variable is not tied to a particular instance of a class, but rather
# the class itself.

# Queestion 4
# What does attr_accessor do?
# attr_accessor automatically defines default getters and setters for symbols
# provided to it.

# Question 5
# How would you describe this expression: Dog.some_method
# .some_method is a class method being called on class Dog.

# Question 6
# In Ruby, what's the difference between subclassing and mixing in modules?
# A subclass can inherits all the behavior of its superclasses, but for each
# class in the method lookup chain, methods that are found within modules included
# in that class take precedence over duplicate methods defined in the class iteself.

# Question 7
# Given that I can instantiate a user like this: User.new('Bob'),
# what would the initialize method look like for the User class?
# def initialize(name)
#   @name = name
# end

# Question 8
# Can you call instance methods of the same class from other instance methods
#  in that class?
# Yes, as long as they are public or protected, and not private?

# Question 9
# When you get stuck, what's the process you use to try to trap the error?
# I frequenly turn to binding pry, and use it as sort of an alternative to irb,
# since it will return the value of variables from within the scope that it is called.
# I'm a big fan of digging directly into code.
