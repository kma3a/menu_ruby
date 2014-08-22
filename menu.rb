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
    @order = ""
  end
  
  def parse_order
    input.each_with_index do |num, index|
      case num 
        when 1
        order << meal.entree
        when 2
        order << meal.side
        when 3
        order << meal.drink
        when 4
        order << meal.dessert
        else
        order << "error"
      end
      unless index == (input.length-1)
        order << ", "
      end
    end
    order
  end
end

