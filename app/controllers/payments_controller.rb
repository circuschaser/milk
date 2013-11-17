class PaymentsController < ApplicationController
  def new
		@buyer = Buyer.find(params[:buyer_id])
  	@payment = @buyer.payments.build
  end

	def create
		@buyer = Buyer.find(params[:buyer_id])
		@payment = @buyer.payments.create(params[:payment])
		if @payment.save
			redirect_to buyer_path(@buyer)
			# or (@payment.buyer)
		else
      render 'new'
	    end
	end

	def destroy
		@payment = Payment.find(params[:id])
		@payment.destroy
		redirect_to buyer_path(@payment.buyer)
	end
end
