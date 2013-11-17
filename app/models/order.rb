class Order < ActiveRecord::Base
  attr_accessible :milk, :buttermilk, :cream,
  								:driver,
  								:buyer_id,
  								:milkrun_id

  belongs_to :buyer
  belongs_to :milkrun

  validates :buyer, presence: true

  # accepts_nested_attributes_for :milkruns

# DEFINE MILK - BUTTERMILK - CREAM
  def m
    if milk.nil?
      0
    else
      milk
    end
  end

  def b
    if buttermilk.nil?
      0
    else
      buttermilk
    end
  end

  def c
    if cream.nil?
      0
    else
      cream
    end
  end

# CALCULATIONS

  def m_cost
	  	milkrun.mprice * m
  end

  def b_cost
	  	milkrun.bprice * b
  end

  def c_cost
	  	milkrun.cprice * c
  end

  def gas_cost
  	if driver?
  		0
  	else
  		milkrun.gas / (milkrun.orders.count - 1)
  	end
  end

  def ice_cost
    if driver?
      0
    else
    	milkrun.ice / (milkrun.orders.count - 1)
    end
  end

  def order_cost
    m_cost + b_cost + c_cost
  end

  def trip_cost
    if driver?
      0
    else
    	gas_cost + ice_cost
    end
  end

  def ppg
    if driver?
      0
    else
      ppg = trip_cost / cap / milkrun.mprice
      ppg.round(2)
    end
  end

  def cap
    if driver?
      0
    else
      m + b + c
    end
  end

end
