class Order < ActiveRecord::Base
  attr_accessible :milk, :buttermilk, :cream,
  								:driver,
  								:buyer_id,
  								:milkrun_id,
                  :date

  belongs_to :buyer
  belongs_to :milkrun

  validates :buyer, presence: true

  # accepts_nested_attributes_for :milkruns

  def cycle
    milkrun.cycle
  end

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

  def gallons
    m + b + c
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
    milkrun.gas / milkrun.orders.count
  end

  def ice_cost
    milkrun.ice_cost / milkrun.orders.count
  end

  def order_cost
    m_cost + b_cost + c_cost
  end

  # 

  def ppg
    ppg = trip_cost / gallons
    ppg.round(2)
  end

  # 

  def trip_cost
  	gas_cost + ice_cost
  end

  def under
    if gallons <= (milkrun.total_trip_cost/(milkrun.orders.count)).ceil
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
      # X = count buyers capped at $1
      x += 1 unless i.under == false

      # sum trip cost contributions for capped buyers
      x_total += i.gallons unless i.under == false
    end

    # Y = buyers not capped at $1
    y = milkrun.orders.count - x

    if under
      capped = gallons
      capped.round(2)
    else
      capped = (milkrun.total_trip_cost - x_total) / y
      # round to nearest .25
      share = ((capped * 4).round / 4.0).round(2)

      # check break-even, add .25 if negative
      if (share * y + x_total) < milkrun.total_trip_cost
        share += 0.25
        share
      else
        share
      end
    end
  end

  def capped_ppg
    x = 0
    x_total = 0
    
    milkrun.orders.each do |i|
      i.under
      # X = count buyers capped at $1
      x += 1 unless i.under == false

      # sum trip cost contributions for capped buyers
      x_total += i.gallons unless i.under == false
    end

    # Y = buyers not capped at $1
    y = milkrun.orders.count - x

    if under
      capped_ppg = gallons / gallons
      capped_ppg.round(2)
    else
      share = (milkrun.total_trip_cost - x_total)
      uncapped_ppg =  capped / gallons
      uncapped_ppg.round(2)
      # share.round(2)
    end
  end

  def amount_due
    order_cost + capped
  end

end
