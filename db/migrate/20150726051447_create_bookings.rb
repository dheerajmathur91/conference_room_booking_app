class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
    	t.string :name
    	t.string :email
    	t.string :contact_number
    	t.decimal :total_amount
    	t.timestamps null: false
    end
  end
end
