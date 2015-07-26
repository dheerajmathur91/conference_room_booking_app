class Booking < ActiveRecord::Base
	has_many :line_items, dependent: :destroy
	validates_format_of :email,
                  :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i,
                  :message => "You must supply a valid email"
end