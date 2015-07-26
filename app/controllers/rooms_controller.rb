class RoomsController < ApplicationController
	def index
		@rooms = Room.all
	end

	def new
		@room = Room.new
	end

	def create
		@room = Room.new(room_params)
		if @room.save
		redirect_to @room
		else
		render 'new'
		end
	end

	def show
		@room = Room.find_by_id(params[:id]) or not_found
	end

	def edit
		@room = Room.find_by_id(params[:id]) or not_found
	end

	def destroy
	    @room = Room.find_by_id(params[:id]) or not_found
	    @room.destroy
	 
	    redirect_to rooms_path
	end

	def update
	    @room = Room.find_by_id(params[:id]) or not_found
	 
	    if @room.update(room_params)
	      redirect_to @room
	    else
	      render 'edit'
	    end
	end

	def show_bookings
		@room = Room.find_by_id(params[:room_id]) or not_found
		@line_items = LineItem.where(:room_id => @room.id)
	end

	private
		def room_params
			params.require(:room).permit(:number, :capacity, :price)
		end

		def not_found
		  	render file: "#{Rails.root}/public/404.html", layout: false, status: 404
		end
end