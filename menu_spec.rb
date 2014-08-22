require_relative "menu"

describe Meal do

  let(:meal) {Meal.new({entree: 'sushi', side: 'rice', drink: 'sake', dessert: 'melon pan', repeat: 'rice'})}
  let(:meal2) {Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee', repeat: 'coffee'})}

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
      expect(meal2.dessert).to eq(nil)
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

  context '#parse_order' do
    it 'returns the order' do
      expect(meal2.parse_order([1,2,3])).to eq(["eggs", "toast", "coffee"])
    end

    it 'stops at an error' do 
      expect(meal2.parse_order([1,2,4])).to eq(["eggs", "toast", "error"])
    end

    it 'will have error if two in a row that can not be done' do 
      expect(meal2.parse_order([1,1,2])).to eq(["eggs", "error"])
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

    it 'returns error if nil' do
      expect(meal2.order(4,5)).to eq(["error"])
    end
  end

end

describe MealController do 
  
  let(:morning) {Meal.new({entree: 'eggs', side: 'toast', drink: 'coffee', repeat: 'coffee'})}
  let(:night) {Meal.new({entree: 'steak', side:'potato', drink: 'wine', dessert: 'cake', repeat: 'potato'})}
  
  let(:con) {MealController.new({morning: morning, night: night})}

  context '#initialize' do
    it ' creates a controller object' do
      expect(con).to be_an_instance_of(MealController)
    end

    it 'returns an error if no arguemts' do
      expect{MealController.new}.to raise_error(ArgumentError)
    end
  end

  context '#morning' do
    it 'should be an instance of meal' do
      expect(con.morning).to be_an_instance_of(Meal)
    end
  end

  context '#night' do
    it 'should be an instance of meal' do
      expect(con.night).to be_an_instance_of(Meal)
    end
  end

  context '#place_order' do
    it 'takes order and sends it to the correct model' do
      expect(con.place_order('morning, 1, 2, 3')).to eq(["eggs", "toast", "coffee"])
    end
  end

end

describe MealViews do

  extend MealViews
    let(:user_input) {'morning, 1, 2, 3'}

    it 'gets the users order' do
      expect(MealViews::StartView.render(user_input)).to eq('morning, 1, 2, 3')
    end

  it 'displays a list of what you ordered' do
    expect(MealViews::RegularView.render(["eggs", "toast", "error"])).to eq("eggs, toast, error")
  end

end
