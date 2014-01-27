class MilkrunsController < ApplicationController
  def new
  	@cycle = Cycle.find(params[:cycle_id])
  	@milkrun = @cycle.milkruns.build
  end

	def create
  	@cycle = Cycle.find(params[:cycle_id])
		@milkrun = @cycle.milkruns.create(params[:milkrun])
	end

	def duplicate
  	@cycle = Cycle.find(params[:cycle_id])
		@milkrun = @cycle.milkruns.last
		@new = @milkrun.dup
		@milkrun.orders.each do |x|
			@new.orders << x.dup
		end

		if @new.save
			@new.date += 3.weeks
			@new.save
			redirect_to edit_milkrun_path(@new)
		else
			redirect_to '/milkruns'
		end
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
		redirect_to :back
	end

end
