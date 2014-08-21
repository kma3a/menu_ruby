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

describe Controller do 
  
  let(:night) {Meal.new({entree: 'steak', side: 'potato', drink: 'wine', dessert: 'cake'})}
  let(:morning) {Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee'})}
  
  let(:con) {Controller.new({morning: morning, night: night, input: 'morning, 1'})}

  context '#initialize' do
    it ' creates a controller object' do
      expect(con).to be_an_instance_of(Controller)
    end

    it 'returns an error if no arguemts' do
      expect{Controller.new}.to raise_error(ArgumentError)
    end
  end

  context '#moring' do
    it 'should be an instance of meal' do
      expect(con.morning).to be_an_instance_of(Meal)
    end
  end

end
