class MotorVehicle
  attr_accessor :color, :model, :speed, :engine
  attr_reader :year

  @@number_of_motorvehicles = 0

  def self.number_of_motorvehicles
    puts "This program has created #{@@number_of_motorvehicles} of motor vehicles"
  end

  module Towable
  def can_tow?(pounds)
    pounds < 2000 ? true : false
  end
end

  def initialize(y, c, m, s, e) # set up state, allows instance variables to be set to the values passed in when creating a new object with .new method
    @year = y
    @color = c
    @model = m
    @speed = s
    @engine = e
    @@number_of_motorvehicles += 1
  end

  def accelerate(s) 
    self.speed += s #self makes usre ruby knows were not creating a new variable "speed", but calling the seter method "speed"
    puts "You accelerate to #{speed}"
  end

  def brake(s)
    self.speed -= s
    puts "You slow down to #{speed}"
  end

  def park(e)
    self.speed = 0
    self.engine = "Off"
    puts "You pull over, stop, and turn the engine #{engine}"
  end

  def spray_paint(c)
    self.color = c
    puts "You spray paint your car #{color}"
  end

  def info
    puts "Your car is a #{year} #{color} #{model} going #{speed} with the engine #{engine}"
    puts
  end

  def age
    "Your #{self.model} is #{years_old} years old"
  end

  private

  def years_old
    Time.now.year - self.year.to_i
  end
end



class Car < MotorVehicle
  WEIGHT = 2000
  include Towable
end

class Truck < MotorVehicle
  WEIGHT = 5000
end

acura = Car.new("2008", "White", "TL", 0, "On")
acura.info

acura.accelerate(60)
acura.info
acura.brake(30)
acura.info
acura.park("Off")
acura.info
acura.spray_paint("Red")
acura.info
puts acura.year
puts '---------------'
puts MotorVehicle.ancestors
puts
puts Car.ancestors
puts
puts Truck.ancestors

puts acura.age


