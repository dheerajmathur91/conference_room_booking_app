class BookingsController < ApplicationController
	def index
		@bookings = Booking.all 
	end

	def new
		@booking = Booking.new
	end

	def create
		@booking = Booking.new(booking_params)
		if @booking.save
			redirect_to @booking
		else
			render 'new'
		end
	end

	def show
		@booking = Booking.find_by_id(params[:id]) or not_found
	end

	def edit
		@booking = Booking.find_by_id(params[:id]) or not_found
	end

	def destroy
	    @booking = Booking.find_by_id(params[:id]) or not_found
	    @booking.destroy
	 
	    redirect_to bookings_path
	end

	def update
	    @booking = Booking.find_by_id(params[:id]) or not_found
	 
	    if @booking.update(booking_params)
	      redirect_to @booking
	    else
	      render 'edit'
	    end
	end

	private
		def booking_params
			params.require(:booking).permit(:name,:email, :contact_number)
		end

		def not_found
		  	render file: "#{Rails.root}/public/404.html", layout: false, status: 404
		end
end
