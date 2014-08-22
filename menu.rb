class Meal
  
  attr_reader :entree, :side, :drink, :dessert, :repeat

  def initialize(args)
    @entree = args[:entree]
    @side = args[:side]
    @drink = args[:drink]
    @dessert = args.fetch(:dessert, "error")
    @repeat = args[:repeat]
  end

  def order(item_num, count)
    item = get_food(item_num) 
    if count > 1
      check_repeat(item, count)
    else
      [item]
    end
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

  def can_repeat(item)
    item == repeat
  end

  def check_repeat(item, count)
    if can_repeat(item)
      ["#{item}(x#{count})"]
    else
      [item,'error']
    end
  end
 

end


morning = Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee', repeat: 'cofffee'})
night = Meal.new({entree: 'steak', side: 'potato', drink: 'wine', dessert: 'cake', repeat: 'potato'})

class MealController

  attr_accessor :output
  attr_reader :meal, :input

  def initialize(args)
    @meal = args[:meal]
    @input = args[:input]
    @output = []
  end
  
  def parse_order
    num_count = 0
    input.each do |num|
      if output.last == "error"
        break
      end
     num_count = input.count(num)
     self.output += meal.order(num, num_count) 
    end
    output
  end

end

