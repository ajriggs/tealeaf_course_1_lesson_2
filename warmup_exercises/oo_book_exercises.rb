module Cargoable
  def carry_heavy_load(pounds)
    puts "I bet your car can't carry #{pounds}lbs. of weight!"
  end
end

class Vehicle
  attr_accessor :color, :gallons, :year, :model, :current_speed
  @@number_of_vehicles = 0

  def initialize(year, color, model)
    @@number_of_vehicles += 1
    self.year = year
    self.model = model
    self.color = color
    self.current_speed = 0
  end

  def self.how_many_vehicles?
    puts "There are #{@@number_of_vehicles} vehicles on the road."
  end

  def self.mpg(miles, gallons)
    puts "Avg. Fuel Efficiency: #{miles/gallons} MPG"
  end

  def accelerate
    self.current_speed += 1
  end

  def brake
    self.current_speed -= 1
  end

  def kill
    self.current_speed = 0
  end

  def say_current_speed
    "You are currently traveling at #{current_speed}MPH."
  end

  def spray_paint(color)
    self.color = color
  end

  def age
    "This #{self.model} is #{calculate_age} years old."
  end

  private

  def calculate_age
    Time.now.year - self.year
  end

end

class MyCar < Vehicle
  attr_accessor :trunk_size
  NUMBER_OF_DOORS = 4
  def initialize(year, color, model, trunk_size)
    super(year, color, model)
    self.trunk_size = trunk_size
  end
end

class MyTruck < Vehicle
  include Cargoable

  attr_accessor :bed_size
  NUMBER_OF_DOORS = 2

  def initialize(year, color, model, bed_size)
    super(year, color, model)
    self.bed_size = bed_size
  end

end

ranger = MyTruck.new(2001, "White", "Ford Ranger", "Small Bed")

class Student
  attr_accessor :name
  attr_writer :grade

  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end

  def better_grade_than?(student)
    grade < student.grade
  end

  protected

  attr_reader :grade
end
