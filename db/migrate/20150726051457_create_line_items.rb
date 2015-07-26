class CreateLineItems < ActiveRecord::Migration
  def change
    create_table :line_items do |t|
    	t.references :booking, index: true, foreign_key: true
    	t.references :room, index: true, foreign_key: true
    	t.datetime :start_time
    	t.datetime :end_time
    	t.decimal :price
    	t.timestamps null: false
    end
  end
end
