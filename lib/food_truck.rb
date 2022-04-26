require_relative 'item'

class FoodTruck
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def check_stock(item)
    @inventory[item]
  end

  def stock(item, quant)
    @inventory[item] += quant
  end

  def potential_revenue
    @inventory.sum { |item, quant| item.price * quant }
  end
end
