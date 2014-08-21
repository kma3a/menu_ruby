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

class Controller

  attr_reader :morning

  def initialize(args)
    @morning = args[:morning]
    @night = args[:night]
    @input = args[:input]

  end

end
