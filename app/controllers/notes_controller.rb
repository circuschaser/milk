class NotesController < ApplicationController
  def new
		@buyer = Buyer.find(params[:buyer_id])
  	@note = @buyer.notes.build
  end

	def create
		@buyer = Buyer.find(params[:buyer_id])
		@note = @buyer.notes.create(params[:note])
		if @note.save
			redirect_to buyer_path(@buyer)
			# or (@note.buyer)
		else
      render 'new'
	    end
	end

	def update
		@note = Note.find(params[:id])
		if @note.update_attributes(params[:note])
			@note.save
      flash[:success] = "Note Updated"
  		redirect_to buyer_path(@note.buyer)
  	else
  		render 'edit'
  	end
  end

	def destroy
		@note = Note.find(params[:id])
		@note.destroy
		redirect_to buyer_path(@note.buyer)
	end
end
