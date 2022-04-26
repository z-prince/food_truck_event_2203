require_relative 'food_truck'
class Event
  attr_reader :name,
              :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(food_truck)
    @food_trucks << food_truck
  end

  def food_truck_names
    @food_trucks.map { |truck| truck.name }
  end

  def food_trucks_that_sell(item)
    @food_trucks.map do |truck|
      truck if truck.inventory.keys.include?(item)
    end.compact
  end

  def sorted_item_list
    list = []
    @food_trucks.each do |truck|
      truck.inventory.each do |item, _quant|
        list << item unless list.include?(item)
      end
    end
    list.sort_by(&:name)
  end

  # will come back to this edit: came back to this, much easier with total_inventory method
  def overstocked_items
    total_inventory.select do |_item, quant_trucks|
      quant_trucks[:quantity] > 50 && quant_trucks[:food_trucks].length > 1
    end.keys
  end

  def total_inventory
    total_hash = {}
    @food_trucks.each do |truck|
      truck.inventory.each do |item, quant|
        if total_hash[item].nil?
          total_hash[item] = { quantity: quant, food_trucks: [truck] }
        else
          total_hash[item][:quantity] += quant
          total_hash[item][:food_trucks] << truck
        end
      end
    end
    total_hash
  end
end
