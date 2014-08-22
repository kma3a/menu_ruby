class Meal
  
  attr_reader :entree, :side, :drink, :dessert

  def initialize(args)
    @entree = args[:entree]
    @side = args[:side]
    @drink = args[:drink]
    @dessert = args.fetch(:dessert, "error")
  end
  def get_food(num)
    case num 
      when 1
      entree
      when 2
      side
      when 3
      drink
      when 4
      dessert
      else
      "error"
    end
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
      if order.last == "error"
        break
      end
     order << meal.get_food(num) 
    end
    order.join(", ")
  end

end

