require 'rails_helper'

RSpec.describe Listing, type: :model do 
  let(:car_brand) {"Honda"}
  let(:car_model) {"Honda City"}
  let(:description) {"White Color"}
  let(:location_of_seller) {"Kajang"}
  let(:price) {"50000"}

  let(:listing) { Listing.create(car_brand: car_brand, car_model: car_model, description: description, location_of_seller: location_of_seller, price: price) }

  context "association" do
    it { expect(listing).to have_many(:bookings) }
    it { expect(listing).to belong_to(:user) }
  end

  context "search" do 
    it "should find the result by car_brand" do
      search_result = Listing.car_brand(listing.car_brand)    # Alternative way of writing ---> search_result = Listing.car_brand("Honda")
      expect{ (search_result).to eq([listing]) }
    end

    it "should find the result by car_model" do
      search_result = Listing.car_model(listing.car_model)
      expect{ (search_result).to eq([listing]) }
    end
  end 

end