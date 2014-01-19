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
			m.gasprice = "0"
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

	  @x = 0
	  milkruns.each do |m|
	  	order = m.orders.create(date: m.date)
		  name = @buyers[@x]
	  	order.update_attribute(:buyer_id, name.id)
		  order.update_attribute(:driver, true)
	  	@x += 1
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
