class MilkrunsController < ApplicationController
  def new
  	@milkrun = Milkrun.new
  end

	def create
		@milkrun = Milkrun.new(params[:milkrun])
		user = User.find(@milkrun[:user_id])
		user.milkruns << @milkrun
		if @milkrun.save
			redirect_to root_url
		else
      render 'new'
	    end
	end

	def destroy
		@milkrun = Milkrun.find(params[:id])
		@milkrun.destroy
		redirect_to :back
	end

end
