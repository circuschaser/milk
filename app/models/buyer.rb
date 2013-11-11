class Buyer < ActiveRecord::Base
  attr_accessible :name, :email, :phone, :altphone

  has_one :account
  has_many :payments, through: :account

  has_many :orders
  has_many :milkruns, through: :orders

  accepts_nested_attributes_for :account, :payments, :orders

  scope :active, where(active: true)
  scope :inactive, where(active: false)

end
