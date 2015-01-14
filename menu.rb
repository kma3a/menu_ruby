class Meal
  
  attr_reader :item

  def initialize(args)
    @item = { "1" => args[:entree],
    "2" => args[:side],
    "3" => args[:drink],
    "4" => args.fetch(:dessert, "error"),
    "repeat" => args[:repeat]}
  end

  def get_order(input)
    return ["error"] if input.empty?
    parse_order(input)
  end
private
  def parse_order(input)
    num_count = 0
    output = []
    input.sort.each do |num|
      if output.last == "error"
        break
      end
     num_count = input.count(num)
     output += order(num, num_count) 
    end
    output.uniq
  end

  def order(item_num, count)
    food = get_food(item_num) 
    if count > 1
      check_repeat(item_num, count)
    else
      [food]
    end
  end

  def get_food(num)
    item[num]
  end

  def can_repeat(item_num)
    item_num == item["repeat"]
  end

  def check_repeat(item_num, count)
    if can_repeat(item_num)
      ["#{item[item_num]}(x#{count})"]
    else
      [item[item_num],'error']
    end
  end
 

end

class MealController

  attr_reader :meals

  def initialize(args)
    @meals = {"morning" => args[:morning], "night" => args[:night]}
  end

  def start(user = gets.chomp)
    place_order(MealViews::StartView.render(user))
  end

private

  def check_input(input)
    input.length <= 1
  end

  def place_order(string)
    input_array = string.split(", ")
    return "error" if check_input(input_array)
    MealViews::RegularView.render(meals[input_array.shift.downcase].get_order(input_array))
  end

end


module MealViews

  class StartView
    def self.render(user_input = gets.chomp)
      user_input
    end
  end

  class RegularView
    def self.render(output)
      output.join(", ")
    end
  end

end

morning = Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee', repeat: '3'})
night = Meal.new({entree: 'steak', side: 'potato', drink: 'wine', dessert: 'cake', repeat: '2'})


meal1 = MealController.new({morning: morning, night:night})
puts meal1.start
