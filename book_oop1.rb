class GoodDog
  puts "This is class GoodDog"
  include DogBark
end

module DogBark
  def dog_bark
    puts "Woof!"    
  end
end

sparky = GoodDog.new
