class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
    	t.string :number
    	t.integer :capacity
    	t.decimal :price
    	t.timestamps null: false
    end
  end
end
