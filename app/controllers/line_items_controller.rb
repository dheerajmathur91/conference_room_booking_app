class LineItemsController < ApplicationController
	def create
		@booking = Booking.find_by_id(params[:booking_id]) or not_found
	    @line_item = @booking.line_items.create(line_item_params)
	    session[:errors] = ""
	    if @line_item
	    	@line_item.price = @line_item.room.price * ((@line_item.end_time - @line_item.start_time)/3600).ceil
	    	if @line_item.save
	    		update_booking_total_amount(@line_item.booking)
	    		session[:errors] = ""
	    	else
	    		update_error_messages_to_session(@line_item)
	    	end
	    end   
	    redirect_to booking_path(@booking) 
	end
 	def destroy
	    @booking = Booking.find_by_id(params[:booking_id]) or not_found
	    @line_item = @booking.line_items.find_by_id(params[:id])
	    @line_item.destroy
	    update_booking_total_amount(@booking)
	    redirect_to booking_path(@booking)
	end

	
  	private
    def line_item_params
      params.require(:line_item).permit(:room_id, :start_time, :end_time)
    end

    def update_booking_total_amount(booking)
    	booking.total_amount = booking.line_items.map(&:price).sum()
    	booking.save!
    end

    def update_error_messages_to_session(line_item)
    	booking = line_item.booking
		line_item.errors.full_messages.each do |msg|
  			if session[:errors].blank?
  				temp_hash = {}
  				temp_hash[booking.id.to_s] = msg 
  				session[:errors] = temp_hash.to_json
  			else
  				temp_hash = JSON.parse(session[:errors])
  				temp_hash[booking.id.to_s] = temp_hash[booking.id.to_s].to_s + msg 
  				session[:errors] = temp_hash.to_json
  			end 
		end 
    end

    def not_found
	  	render file: "#{Rails.root}/public/404.html", layout: false, status: 404
	end
end
