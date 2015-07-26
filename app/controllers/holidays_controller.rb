class HolidaysController < ApplicationController
	def index
		@holidays = Holiday.all 
	end

	def new
		@holiday = Holiday.new
	end

	def create
		@holiday = Holiday.new(holiday_params)
		if @holiday.save
			redirect_to @holiday
		else
			render 'new'
		end
	end

	def show
		@holiday = Holiday.find_by_id(params[:id]) or not_found
	end

	def edit
		@holiday = Holiday.find_by_id(params[:id]) or not_found
	end

	def destroy
	    @holiday = Holiday.find_by_id(params[:id]) or not_found
	    @holiday.destroy
	 
	    redirect_to holidays_path
	end

	def update
	    @holiday = Holiday.find_by_id(params[:id]) or not_found
	 
	    if @holiday.update(holiday_params)
	      redirect_to @holiday
	    else
	      render 'edit'
	    end
	end

	private
		def holiday_params
			params.require(:holiday).permit(:name,:holiday_date)
		end

		def not_found
		  	render file: "#{Rails.root}/public/404.html", layout: false, status: 404
		end
end
