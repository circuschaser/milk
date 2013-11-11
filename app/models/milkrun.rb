class Milkrun < ActiveRecord::Base
  attr_accessible :date, :gasprice, :mpg, :iceprice

  has_many :orders
  has_many :buyers, through: :orders

  accepts_nested_attributes_for :order, :buyers

end
