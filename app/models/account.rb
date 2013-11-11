class Account < ActiveRecord::Base
  attr_accessible :balance

  belongs_to :buyer

  has_many :orders, through: :buyer
  has_many :payments

  accepts_nested_attributes_for :payments, :orders

end
