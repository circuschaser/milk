class CyclesController < ApplicationController

	def new
  	@cycle = Cycle.new
	end

	def create
  	@cycle = Cycle.new(params[:cycle])
		if @cycle.save
			@cycle.populate
			@cycle.setlast
			redirect_to cycles_path
		else
      render 'new'
    end
	end

	def show
		@cycle = Cycle.find(params[:id])
	end

	def destroy
  	@cycle = Cycle.find(params[:id])
  	@cycle.destroy
  	redirect_to :back
	end

	def update
		@cycle = Cycle.find(params[:id])
		if @cycle.update_attributes(params[:cycle])
			@cycle.resetdates
			@cycle.setlast
			@cycle.save
  		redirect_to cycle_path(@cycle)
  	else
  		render 'edit'
  	end
	end

end
