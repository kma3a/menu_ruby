class Meal
  
  attr_reader :entree, :side, :drink, :dessert

  def initialize(args)
    @entree = args[:entree]
    @side = args[:side]
    @drink = args[:drink]
    @dessert = args[:dessert]
  end

end


morning = Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee'})
night = Meal.new({entree: 'steak', side: 'potato', drink: 'wine', dessert: 'cake'})

class MealController

  attr_accessor :order
  attr_reader :meal, :input

  def initialize(args)
    @meal = args[:meal]
    @input = args[:input]
    @order = []
  end
  
  def parse_order
    input.each do |num|
     order << get_food(num) 
    end
    order.join(", ")
  end

  def get_food(num)
    case num 
      when 1
      meal.entree
      when 2
      meal.side
      when 3
      meal.drink
      when 4
      meal.dessert
      else
      "error"
    end
  end
end

