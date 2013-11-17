class Buyer < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :phone, :altphone, :deposit

  has_many :orders, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :milkruns, through: :orders

  accepts_nested_attributes_for :payments, :orders

  scope :active, where(active: true)
  scope :inactive, where(active: false)

  def balance
  end

  def name
  	"#{firstname + " " + lastname}"
  end

end
