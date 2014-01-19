class Milkrun < ActiveRecord::Base
  attr_accessible :cycle_id,
                  :date,
  								:mprice, :bprice, :cprice,
  								:gasprice, :distance, :mpg,
  								:iceprice,
  								:cool1, 		:cool2, 		:cool3, 		:bag,
  								:cool1_ice, :cool2_ice, :cool3_ice, :bag_ice

  has_many :orders, dependent: :destroy
  has_many :buyers, through: :orders
  belongs_to :cycle

  scope :active, where(active: true)
  scope :inactive, where(active: false)

  default_scope order: 'date ASC'

  accepts_nested_attributes_for :orders, :buyers

  def fillorders
    @buyers = Buyer.active
    @driver = orders.find_by_driver(true).buyer
    d = orders.find_by_driver(true)

    d.update_attribute(:milk, @driver.perm_milk)
    d.update_attribute(:buttermilk, @driver.perm_butter)
    d.update_attribute(:cream, @driver.perm_cream)

    @d = Buyer.where("id = ?", @driver.id)
    @remaining = (@buyers - @d)

    # orders.destroy_all

    @remaining.count.times do
      @order = orders.create(date: date)
      end

    @x = 0
    @orders = orders[1..-1]
    @orders.each do |o|
      name = @remaining[@x]
      o.update_attribute(:buyer_id, name.id)
      o.update_attribute(:milk, name.perm_milk)
      o.update_attribute(:buttermilk, name.perm_butter)
      o.update_attribute(:cream, name.perm_cream)
      @x += 1
    end
  end

  def eraseorders
    @orders = orders
    @driver = orders.where('driver = ?', true)
    @remaining = (@orders - @driver)
    
    @remaining.each do |x|
      x.destroy
    end

    d = orders.find_by_driver(true)

    d.update_attribute(:milk, 0)
    d.update_attribute(:buttermilk, 0)
    d.update_attribute(:cream, 0)
  end

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
    ( x * 2 ).round(2) / 2.0
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
      when order_count == 0
        ice = 0      
  		when order_count <= cool1 && order_count > 0
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
      t += i.gallons
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

  def total_due
    t = 0
    orders.each do |i|
      t += i.amount_due
    end
    t
  end


end



