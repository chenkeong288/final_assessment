class AddReferenceToBookings < ActiveRecord::Migration[5.1]
  def change
    add_reference :bookings, :user, foreign_key: true, index: true
    add_reference :bookings, :listing, foreign_key: true, index: true
  end
end
