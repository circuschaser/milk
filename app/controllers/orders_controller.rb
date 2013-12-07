class OrdersController < ApplicationController
  def new
		@milkrun = Milkrun.find(params[:milkrun_id])
  	@order = @milkrun.orders.build
  end

	def create
		@milkrun = Milkrun.find(params[:milkrun_id])
		@order = @milkrun.orders.create(params[:order])
		@order.update_attribute(:date, @milkrun.date)
		if @order.save
			redirect_to milkrun_path(@milkrun)
		else
      render 'new'
	    end
	end

	def update
		@order = Order.find(params[:id])
		if @order.update_attributes(params[:order])
			@order.save
      flash[:success] = "The Order was successfully updated"
      redirect_to milkrun_path(@order.milkrun)
    else
      render 'edit'
    end
  end

	def destroy
		@order = Order.find(params[:id])
		@order.destroy
		redirect_to :back
	end

end
