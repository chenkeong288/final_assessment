class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :car_brand
      t.string :car_model
      t.string :description
      t.string :location_of_seller
      t.timestamps
    end
  end
end
