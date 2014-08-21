require_relative "menu"

describe Meal do

  let(:meal) {Meal.new({entree: 'sushi', side: 'rice', drink: 'sake', dessert: 'melon pan'})}
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

    it 'returns nil if there is no dessert' do
      expect(meal2.dessert).to eq(nil)
    end
  end
end

describe MealController do 
  
  let(:meal) {Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee'})}
  
  let(:con) {MealController.new({meal: meal, input: [1,2,3]})}

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

end
