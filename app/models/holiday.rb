class Holiday < ActiveRecord::Base
	validates :name, presence: true
	validates :holiday_date, presence: true
end