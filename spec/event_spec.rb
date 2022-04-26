require 'rspec'
require_relative '../lib/event'

RSpec.describe Event do
  describe 'attributes' do
    before :each do
      @event = Event.new('South Pearl Street Farmers Market')
    end

    it 'has a name' do
      expect(@event.name).to eq 'South Pearl Street Farmers Market'
    end

    it 'has food trucks' do
      expect(@event.food_trucks).to eq []
    end
  end

  describe 'behaviors' do
    before :each do
      @event = Event.new('South Pearl Street Farmers Market')
      @food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      @item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      @item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      @item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      @item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new('Palisade Peach Shack')
      @food_truck3.stock(@item1, 65)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'can add food trucks' do
      expect(@event.food_trucks).to eq [@food_truck1, @food_truck2, @food_truck3]
    end

    it 'can return food truck names' do
      expect(@event.food_truck_names).to eq ['Rocky Mountain Pies', 'Ba-Nom-a-Nom', 'Palisade Peach Shack']
    end

    it 'can return food trucks that sell particular items' do
      expect(@event.food_trucks_that_sell(@item1)).to eq [@food_truck1, @food_truck3]
      expect(@event.food_trucks_that_sell(@item4)).to eq [@food_truck2]
    end
  end
end
