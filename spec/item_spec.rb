require 'rspec'
require_relative '../lib/item'

RSpec.describe Item do
  describe 'attributes' do
    before :each do
      @item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
      @item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
    end

    it 'has a name' do
      expect(@item2.name).to eq 'Apple Pie (Slice)'
    end

    it 'has a price' do
      expect(@item2.price).to eq 2.50
    end
  end
end
