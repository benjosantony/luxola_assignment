class Product < ActiveRecord::Base
  validates_presence_of :name, :description, :price
  validates_with MoneyValidator, fields:[:price]
  validates_numericality_of :price
end

