require_relative "menu"

describe Meal do

  let(:meal) {Meal.new({entree: 'sushi', side: 'rice', drink: 'sake', dessert: 'melon pan', repeat: 'rice'})}
  let(:meal2) {Meal.new({entree: 'sushi', side: 'rice', drink: 'sake'})}

  context '#initialize' do

    it 'creates a meal object' do
      expect(meal).to be_an_instance_of(Meal)
    end

    it 'requires parameters' do
      expect{Meal.new}.to raise_error(ArgumentError)
    end
  end

  context '#entree' do

    it 'returns the entree' do
      expect(meal.entree).to eq('sushi')
    end
  end

  context '#side' do
    it 'returns the side' do
      expect(meal.side).to eq('rice')
    end
  end

  context '#drink' do
    it 'returns the drink' do
      expect(meal.drink).to eq('sake')
    end
  end

  context '#dessert' do
    it 'returns the dessert' do
      expect(meal.dessert).to eq('melon pan')
    end

    it 'returns error if there is no dessert' do
      expect(meal2.dessert).to eq("error")
    end
  end

  context '#repeat' do
    it 'returns an item that can be repeated' do
      expect(meal.repeat).to eq('rice')
    end
  end

  context '#get_food' do
    it 'takes in number and outputs food' do
      expect(meal.get_food(1)).to eq("sushi")
    end

    it 'returns error if number is not in the selection' do
      expect(meal2.get_food(5)).to eq("error")
    end
  end
  
  context '#can_repeat' do
    it 'returns true if the item can be repeated' do
      expect(meal.can_repeat('rice')).to eq(true)
    end

    it 'returns false if the item can not be repeated' do
      expect(meal.can_repeat('sushi')).to eq(false)
    end
  end
  
  context '#check_repeat' do
    it 'returns item with count if it can repeat' do
      expect(meal.check_repeat('rice', 2)).to eq(["rice(x2)"])
    end

    it 'should return error if the pervious item can not be repeated' do
      expect(meal.check_repeat('sushi', 2)).to eq(["sushi", "error"])
    end
  end
  
  context "#order" do
    it 'if single will return single output' do
      expect(meal.order(1, 1)).to eq(['sushi'])
    end

    it 'returns array if count > 1 and can not repeat' do
      expect(meal.order(1,2)).to eq(['sushi','error'])
    end

    it 'returns item(xcount) if count > 1 and can repeat' do
      expect(meal.order(2,2)).to eq(['rice(x2)'])
    end
  end

end

describe MealController do 
  
  let(:meal) {Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee', repeat: 'coffee'})}
  
  let(:con) {MealController.new({meal: meal, input: [1,2,3]})}
  let(:con2) {MealController.new({meal: meal, input: [1,2,3,5]})}
  let(:con3) {MealController.new({meal: meal, input: [1,2,4,5]})}
  let(:con4) {MealController.new({meal: meal, input: [1,1,2,3]})}

  context '#initialize' do
    it ' creates a controller object' do
      expect(con).to be_an_instance_of(MealController)
    end

    it 'returns an error if no arguemts' do
      expect{MealController.new}.to raise_error(ArgumentError)
    end
  end

  context '#meal' do
    it 'should be an instance of meal' do
      expect(con.meal).to be_an_instance_of(Meal)
    end
  end

  context '#input' do
    it 'should be a string' do
      expect(con.input.is_a?(Array)).to eq(true)
    end

    it 'returns as an array' do
      expect(con.input).to eq([1,2,3])
    end
  end

  context '#output' do
    it 'should be an empty array' do
      expect(con.output).to eq([])
    end
  end
  
  context '#parse_order' do
    it 'returns the order' do
      expect(con.parse_order).to eq("eggs, toast, coffee")
    end

    it 'stops at an error' do 
      expect(con3.parse_order).to eq("eggs, toast, error")
    end

    it 'will have error if two in a row that can not be done' do 
      expect(con4.parse_order).to eq("eggs, error")
    end

  end


end
