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

  describe 'I3' do
    before :each do
      @event = Event.new('South Pearl Street Farmers Market')
      @item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      @item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      @item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      @item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      @food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new('Palisade Peach Shack')
      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'can sort items' do
      expect(@event.sorted_item_list).to eq [@item2, @item4, @item1, @item3]
    end

    it 'can return overstocked items' do
      expect(@event.overstocked_items).to eq [@item1]
    end

    it 'can list total inventory' do
      expect(@event.total_inventory).to eq({
                                             @item1 => {
                                               quantity: 100,
                                               food_trucks: [@food_truck1, @food_truck3]
                                             },
                                             @item2 => {
                                               quantity: 7,
                                               food_trucks: [@food_truck1]
                                             },
                                             @item4 => {
                                               quantity: 50,
                                               food_trucks: [@food_truck2]
                                             },
                                             @item3 => {
                                               quantity: 35,
                                               food_trucks: [@food_truck2, @food_truck3]
                                             }
                                           })
    end
  end

  describe 'I4' do
    before :each do
      @event = Event.new('South Pearl Street Farmers Market')
      @item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      @item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
      @item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
      @item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
      @food_truck1 = FoodTruck.new('Rocky Mountain Pies')
      @food_truck1.stock(@item1, 35)
      @food_truck1.stock(@item2, 7)
      @food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
      @food_truck2.stock(@item4, 50)
      @food_truck2.stock(@item3, 25)
      @food_truck3 = FoodTruck.new('Palisade Peach Shack')
      @food_truck3.stock(@item1, 65)
      @food_truck3.stock(@item3, 10)
      @event.add_food_truck(@food_truck1)
      @event.add_food_truck(@food_truck2)
      @event.add_food_truck(@food_truck3)
    end

    it 'can list the date' do
      expect(@event.date).to eq '26/04/2022'
      allow(Date).to receive(:today).and_return Date.new(2020, 2, 24)
      @event2 = Event.new('Birthday')
      expect(@event2.date).to eq '24/02/2020'
    end

    it 'can sell items by truck' do
      expect(@event.sell(@item1, 200)).to eq false
    end
  end
end
