class Meal
  
  attr_reader :entree, :side, :drink, :dessert, :repeat

  def initialize(args)
    @entree = args[:entree]
    @side = args[:side]
    @drink = args[:drink]
    @dessert = args[:dessert] #.fetch(:dessert, "error")
    @repeat = args[:repeat]
  end

  def parse_order(input)
    num_count = 0
    output = []
    input.each do |num|
      num = num.to_i
      if output.last == "error"
        break
      end
     num_count = input.count(num)
     output += order(num, num_count) 
    end
    output
  end

  def order(item_num, count)
    item = get_food(item_num) 
    if item == nil
      ['error']
    elsif count > 1
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

  attr_accessor :output, :meal
  attr_reader :night, :morning, :input

  def initialize(args)
    @night = args[:night]
    @morning = args[:morning]
    @input = args[:input]
    @output = []
  end

  def place_order(string)
    input_array = string.split(", ")
    case input_array.shift
    when "morning"
      morning.parse_order(input_array)
    when "night"
      night.parse_order(input_array)
    else
      ["error"]
    end
  end

end


module MealViews

  class StartView
    def self.render(user_input = gets.chomp)
      'Input your order ex: morning, 1, 2, 3'
      user_input
    end
  end

  class RegularView
    def self.render(output)
      output.join(", ")
    end
  end

end