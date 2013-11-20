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
    elsif milkrun.orders.count - 1 <= 0
      milkrun.gas / milkrun.orders.count
    else
      milkrun.gas / (milkrun.orders.count - 1)
    end
  end

  def ice_cost
    if driver?
      0
    elsif milkrun.orders.count - 1 <= 0
      milkrun.ice_cost / milkrun.orders.count
    else
      milkrun.ice_cost / (milkrun.orders.count - 1)
    end
  end

  def order_cost
    m_cost + b_cost + c_cost
  end

  # 
  def pergallon
    if driver?
      0
    else
      m + b + c
    end
  end

  def ppg
    if driver?
      0
    else
      ppg = trip_cost / pergallon
      ppg.round(2)
    end
  end

  # 

  def trip_cost
    if driver?
      0
    else
    	gas_cost + ice_cost
    end
  end

  def under
    if ppg > 1
      true
    else
      false
    end
  end

  def capped
    x = 0
    x_total = 0
    
    milkrun.orders.each do |i|
      i.under
      # X = buyers capped at $1
      x += 1 unless i.under == false

      # add per gallon cost for X
      x_total += i.pergallon unless i.under == false
    end

    # Y = buyers not capped at $1
    y = milkrun.orders.count - x
    if driver?
      0
    elsif under
      capped = pergallon
      capped.round(2)
    else
      uncapped = (milkrun.total_trip_cost - x_total) / (y - 1)
      uncapped.round(2)
    end

  end

  def capped_ppg
    x = 0
    x_total = 0
    
    milkrun.orders.each do |i|
      i.under
      x += 1 unless i.under == false
      x_total += i.pergallon unless i.under == false
    end

    y = milkrun.orders.count - x
    if driver?
      0
    elsif under
      capped_ppg = pergallon / pergallon
      capped_ppg.round(2)
    else
      uncapped_ppg = (milkrun.total_trip_cost - x_total) / y / pergallon
      uncapped_ppg.round(2)
    end

  end






end
