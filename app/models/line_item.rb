class LineItem < ActiveRecord::Base
	validates :room_id, presence: true
	validates :start_time, presence: true
	validates :end_time, presence: true
	validate :validate_time
	belongs_to :booking
	belongs_to :room

	def validate_time
		if self.start_time.wday == 0 or self.start_time.wday == 6 or self.end_time.wday == 0 or self.end_time.wday == 6
			self.errors.add(:base,"Bookings cannot be done for weekends.")
			return
		end
		holidays = Holiday.all.map{|x| x.holiday_date.strftime("%D")}
		if holidays.include? self.start_time.strftime("%D") or holidays.include? self.end_time.strftime("%D")
			self.errors.add(:base,"Bookings cannot be done for holidays.")
			return
		end
		if self.start_time && self.end_time && (self.start_time >= self.end_time)
			self.errors.add(:base,"End time value must be greater than start time value.")
		end
		if (self.start_time < Time.now) or (self.end_time < Time.now)
			self.errors.add(:base,"Booking can only be done for Future.")
		end
		if LineItem.where("room_id = ? and ((start_time > ? and start_time < ?) or (end_time > ? and end_time < ?))",self.room.id,self.start_time,self.end_time,self.start_time,self.end_time).count > 0
			self.errors.add(:base,"Timeslot for this room is already reserved.")
		end
	end
end