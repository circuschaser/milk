class BuyersController < ApplicationController
  def new
  	@buyer = Buyer.new
  end

  def create
		@buyer = Buyer.new(params[:buyer])
		if @buyer.save
			redirect_to active_buyers_path
    end
  end

  def index
  	@buyers = Buyer.order('lastname ASC')
  end

  def show
  	@buyer = Buyer.find(params[:id])
  end

	def update
		@buyer = Buyer.find(params[:id])
		if @buyer.update_attributes(params[:buyer])
			@buyer.save
      flash[:success] = "Family Info Updated"
  		redirect_to active_buyers_path
  	else
  		render 'edit'
  	end
  end

  def activate
		@buyer = Buyer.find(params[:id])
		@buyer.active = true
		if @buyer.save
			flash[:success] = "\"#{@buyer.name.upcase}\" was succesfully Activated"
			redirect_to :back
		else
			flash.now[:error] = "Whoops. SOMETHING WHEN WRONG.\nActivation failed."
			redirect_to :back
		end
  end

  def deactivate
		@buyer = Buyer.find(params[:id])
		@buyer.active = false
		if @buyer.save
			flash[:success] = "\"#{@buyer.name.upcase}\" was succesfully Deactivated"
			redirect_to :back
		else
			flash.now[:error] = "Whoops. SOMETHING WHEN WRONG.\nDeactivation failed."
			redirect_to :back
		end
  end

	def destroy
		@buyer = Buyer.find(params[:id])
		@buyer.destroy
		redirect_to active_buyers_path
	end



end
