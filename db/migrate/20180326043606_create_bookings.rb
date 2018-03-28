class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings do |t|
      t.date :date
      t.time :start_time 
      t.time :end_time 
      t.timestamps
    end
  end
end
