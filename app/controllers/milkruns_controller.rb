class MilkrunsController < ApplicationController
  def new
  	@milkrun = Milkrun.new
  end

	def create
		@milkrun = Milkrun.new(params[:milkrun])

		@milkrun.mprice = "5"
		@milkrun.bprice = "5"
		@milkrun.cprice = "10"

		@milkrun.distance = "260"
		@milkrun.mpg = "20"
		@milkrun.iceprice = "1.75"

		@milkrun.cool1 = "24"
		@milkrun.cool1_ice = "2"

		@milkrun.cool2 = "20"
		@milkrun.cool2_ice = "2"

		@milkrun.cool3 = "20"
		@milkrun.cool3_ice = "2"

		@milkrun.bag = "3"
		@milkrun.bag_ice = "0.5"

		if @milkrun.save
			redirect_to '/milkruns'
		else
      render 'new'
    end
	end

	def show
		@milkrun = Milkrun.find(params[:id])
	end

	def update
		@milkrun = Milkrun.find(params[:id])
		if @milkrun.update_attributes(params[:milkrun])
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
