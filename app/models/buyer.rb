class Buyer < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :email, :phone, :altphone, :deposit

  has_many :orders
  has_many :payments, dependent: :destroy
  has_many :milkruns, through: :orders
  has_many :notes, dependent: :destroy

  accepts_nested_attributes_for :payments, :orders

  default_scope order: 'lastname ASC'

  scope :active, where(active: true)
  scope :inactive, where(active: false)

  validates :firstname, presence: true
  validates :lastname, presence: true


  def name
  	"#{firstname + " " + lastname}"
  end

  def debits
    debits = 0
    orders.each do |x|
      debits += x.amount_due
    end
    debits
  end

  def credits
    credits = 0
    payments.each do |x|
      credits += x.amount
    end
    credits
  end

  def balance
    credits - debits
  end

  def gas_credits
    drives = orders.where(driver: true)
    y = 0
    drives.each do |d|
      y += d.milkrun.total_trip_cost.floor
    end

    credits = payments.where(category: "Gas Credit")
    z = 0
    credits.each do |c|
      z += c.amount
      end

    due = y - z
    due
  end

end
