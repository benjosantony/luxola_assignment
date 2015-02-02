require 'rails_helper'

RSpec.describe Product, :type => :model do

  context 'For a product' do
    subject(:product) {Product.new}
    context 'Product should be valid' do
      it {should have(1).error_on(:name)}
      it {should have(1).error_on(:description)}
      it { should have_at_least(1).errors_on(:price) }

    end

    context 'When price is not a number' do
      subject(:product) {Product.new ({price:'asdads'})}
      it {should have_at_least(1).error_on(:price)}
    end
    context 'When price is an integer' do
      subject(:product) {Product.new ({price:25})}
      it{product.should have(0).errors_on(:price)}
    end

    context 'When price is < 0' do
      subject(:product) {Product.new ({price:-5})}
      it{should have_at_least(1).error_on(:price)}
    end

    context 'When price is a decimal' do
      subject(:product) {Product.new ({price:5.90})}
      it{should have(0).error_on(:price)}
    end

    context 'When price is more than 2 decimal places' do
      subject(:product) {Product.new ({price:5.90523})}
      it{should have_at_least(1).error_on(:price) }
    end

  end


end
