class OrdersController < ApplicationController
  def new
  	@order = Order.new
  end

	def create
		@order = Order.new(params[:order])
		current_user.orders << @order
		if @order.save
			redirect_to root_url
		else
      render 'new'
	    end
	end

end
