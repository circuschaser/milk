class MilkrunsController < ApplicationController

	def index
		@milkruns = Milkrun.order('position ASC')
	end

  def new
  	@cycle = Cycle.find(params[:cycle_id])
		@last = @cycle.milkruns.last
  	@new = @cycle.milkruns.build
  	@buyers = Buyer.active
  	@nondrivers = @buyers.where(drive_order: nil)
  	@drivers = @buyers - @nondrivers
		@drivers.sort! {|x,y| x.drive_order <=> y.drive_order }
 		@orderbuyer = @drivers.last

		@last.orders.each do |x|
			@new.orders << x.dup
		end

		if @new.save
			@new.orders.first.buyer = @orderbuyer
			@new.position = @last.position + 1
			@new.date = @last.date + 3.weeks
			@new.gasprice = "0"
			@new.mprice = "5"
			@new.bprice = "5"
			@new.cprice = "10"
			@new.distance = "260"
			@new.mpg = "20"
			@new.iceprice = "1.75"
			@new.cool1 = "24"
			@new.cool1_ice = "2"
			@new.cool2 = "20"
			@new.cool2_ice = "2"
			@new.cool3 = "20"
			@new.cool3_ice = "2"
			@new.bag = "3"
			@new.bag_ice = "0.5"
			@new.save
			@new.save
			@cycle.setlast
			redirect_to :back
		else
			redirect_to :back
		end  
	end

	def create
  	@cycle = Cycle.find(params[:cycle_id])
		@milkrun = @cycle.milkruns.create(params[:milkrun])
		redirect_to cycle_path(@cycle)
	end

	def home
		@milkrun = @current_run
	end

	def show
		@milkrun = Milkrun.find(params[:id])
	end

  def activate
		@milkrun = Milkrun.find(params[:id])
		@milkrun.active = true
		@milkrun.fillorders
		if @milkrun.save
			redirect_to :back
		else
			flash.now[:error] = "Whoops. SOMETHING WHEN WRONG.\nActivation failed."
			redirect_to :back
		end
  end

  def deactivate
		@milkrun = Milkrun.find(params[:id])
		@milkrun.active = false
		@milkrun.eraseorders
		@milkrun.update_attribute(:gasprice, 0)
		if @milkrun.save
			redirect_to :back
		else
			flash.now[:error] = "Whoops. SOMETHING WHEN WRONG.\nDeactivation failed."
			redirect_to :back
		end
  end

	def p_archive
		@milkrun = Milkrun.find(params[:id])
	end

	def p_pickup
		@milkrun = Milkrun.find(params[:id])
	end

	def instructions
		@milkrun = Milkrun.find(params[:id])
	end

	def update
		@milkrun = Milkrun.find(params[:id])
		if @milkrun.update_attributes(params[:milkrun])
			if @milkrun.gasprice.nil?
				@milkrun.update_attribute(:gasprice, 0)
			end
			@milkrun.save
      flash[:success] = "Settings Updated"
  		redirect_to milkrun_path(@milkrun)
  	else
  		render 'edit'
  	end
  end

	def destroy
		@milkrun = Milkrun.find(params[:id])
		@milkrun.destroy
		@milkrun.cycle.setlast
		redirect_to :back
	end

	def sort
		# params[:prefix] must be same as in <li id> in view
		@milks = params[:milkrun]
		@milks.each_with_index do |id, index|
			Milkrun.update_all({position: index+1}, {id: id})
		end
		@cycle = Milkrun.find(@milks.first).cycle
		@x = 0
		@cycle.milkruns.each do |m|
			m.update_attribute(:date, @cycle.startdate + (@x * 3).weeks)
			@x += 1
		end
		render nothing: true
	end









end
