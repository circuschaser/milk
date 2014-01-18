class Cycle < ActiveRecord::Base
  attr_accessible :name, :startdate, :lastdate

  has_many :milkruns, dependent: :destroy
  accepts_nested_attributes_for :milkruns

  default_scope order: 'startdate ASC'

  def populate
  	@buyers = Buyer.active
  	@buyers.sort! {|x,y| x.drive_order <=> y.drive_order }
  	@mdate = startdate
  	@buyers.count.times do
			@milkrun = milkruns.create(date: @mdate)
			@mdate += 3.weeks
		end

		milkruns.each do |m|
			m.gasprice = "3.29"
			m.mprice = "5"
			m.bprice = "5"
			m.cprice = "10"
			m.distance = "260"
			m.mpg = "20"
			m.iceprice = "1.75"
			m.cool1 = "24"
			m.cool1_ice = "2"
			m.cool2 = "20"
			m.cool2_ice = "2"
			m.cool3 = "20"
			m.cool3_ice = "2"
			m.bag = "3"
			m.bag_ice = "0.5"
			m.save
	  end

	  milkruns.each do |m|
	  	@buyers.count.times do
		  	@order = m.orders.create(date: m.date)
		  end
		  @x = 0
		  m.orders.each do |o|
			  name = @buyers[@x]
		  	o.update_attribute(:buyer_id, name.id)
		  	o.update_attribute(:milk, name.perm_milk)
		  	o.update_attribute(:buttermilk, name.perm_butter)
		  	o.update_attribute(:cream, name.perm_cream)
		  	@x += 1
		  end
		end

	  @x = 0
		milkruns.each do |m|
		  @driver = @buyers[@x]
		  @order = m.orders.find_by_buyer_id(@driver.id)
		  @order.update_attribute(:driver, true)
		  @x += 1
		  m.save
		end

	end

	def setlast
		date = milkruns.last.date
		self.lastdate = date
		self.save
	end

	def resetdates
		@mdate = startdate
  	milkruns.each do |m|
			m.update_attribute(:date, @mdate)
			m.orders.each do |o|
				o.update_attribute(:date, @mdate)
			end
			@mdate += 3.weeks
		end
	end

end
