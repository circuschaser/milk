class Milkrun < ActiveRecord::Base
  attr_accessible :date,
  								:mprice, :bprice, :cprice,
  								:gasprice, :distance, :mpg,
  								:iceprice,
  								:cool1, 		:cool2, 		:cool3, 		:bag,
  								:cool1_ice, :cool2_ice, :cool3_ice, :bag_ice

  has_many :orders, dependent: :destroy
  has_many :buyers, through: :orders

  accepts_nested_attributes_for :orders, :buyers

  def m_orders
  	milk = 0
  	orders.each do |x|
  		milk += x.milk unless x.milk.nil?
  	end
  	milk
  end

  def b_orders
  	butter = 0
  	orders.each do |x|
  		butter += x.buttermilk unless x.buttermilk.nil?
  	end
  	butter
  end

  def c_orders
  	cream = 0
  	orders.each do |x|
  		cream += x.cream unless x.cream.nil?
  	end
  	cream
  end

  def order_count
  	m_orders + b_orders + c_orders
  end

  def order_total
  	(m_orders * mprice) + (b_orders * bprice) + (c_orders * cprice)
  end

  def gas
  	x = distance / mpg * gasprice
    ( x * 2 ).round / 2.0
  end


  def fullcoolers
    fullcoolers = cool1_ice + cool2_ice + cool3_ice
  end

  def freezer_bags
    rem_gallons = order_count - cool1 - cool2 - cool3
    if rem_gallons <= 0
      0
    else
      b = rem_gallons/bag.to_f
      b.ceil
    end
  end

  def ice
		case 
  		when order_count <= cool1
  			ice = cool1_ice
  		when order_count > cool1 && order_count <= (cool1 + cool2)
  			ice = cool1_ice + cool2_ice
  		when order_count > (cool1 + cool2) && order_count <= (cool1 + cool2 + cool3)
  			ice = fullcoolers
  		else
      ice = fullcoolers + (freezer_bags * bag_ice)
  		end
    ice.ceil
  end

  def ice_cost
		ice * iceprice
	end

  def total_unit_cost
    t = 0
    orders.each do |i|
      t += i.pergallon
    end
    t
  end

  def diff
    total_capped_cost - total_trip_cost
  end

  def total_cost
    order_total + gas + ice_cost
  end

  def total_trip_cost
    gas + ice_cost
  end

  def total_capped_cost
    t = 0
    orders.each do |i|
      t += i.capped
    end
    t
  end

end



