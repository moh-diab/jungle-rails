require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'is valid with valid attribute' do
      @category = Category.new
      @product = Product.new(name: 'any name', price: 100, quantity: 10, category: @category)
      expect(@product).to be_valid
    end

    it 'is not valid without a name' do
      @category = Category.new
      @product = Product.new(price: 100, quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Name can't be blank"
    end

    it 'is not valid without price' do
      @category = Category.new
      @product = Product.new(name: 'any name', quantity: 10, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.second).to eq "Price is not a number"

    end

    it 'is not valid without quantity' do
      @category = Category.new
      @product = Product.new(name: 'any name', price: 100, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Quantity can't be blank"
    end

    it 'is not valid without category' do 
      @category = Category.new
      @product = Product.new(name: 'any name', price: 100, quantity: 10)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages.first).to eq "Category can't be blank"
    end
  end
end