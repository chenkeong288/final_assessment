class Listing < ApplicationRecord
  
  belongs_to :user

  has_many :bookings, dependent: :destroy

  #search
  scope :car_brand, -> (input_car_brand) { where("car_brand ILIKE ?", "%#{input_car_brand}%") }
  scope :car_model, -> (input_car_model) { where("car_model ILIKE ?", "%#{input_car_model}%") }
end